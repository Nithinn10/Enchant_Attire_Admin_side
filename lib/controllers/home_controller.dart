import 'dart:developer';

import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  @override
  void onInit(){
    super.onInit();
    getUsername();
  }

  var navIndex = 0.obs;  
  var username = '';

  getUsername() async{
    var n = await firestore.collection('vendors').where('id', isEqualTo: currentUser!.uid).get()
    .then((value){
      if (value.docs.isEmpty) {
        return value.docs.single['vendor_name'];
      }
    });

    username = n;
    print(username);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  var orders = [];

  var confirmed = false.obs;
  var ondelivery = false.obs;
  var delivered = false.obs;


  getOrder(data){
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
        
      }
    }
    print(orders);

  }
 changeStatus({title,status,docID})async{
  var store = firestore.collection('ordered Item').doc(docID);
 await store.set({
  title: status
 },SetOptions(merge: true));
 
}


}
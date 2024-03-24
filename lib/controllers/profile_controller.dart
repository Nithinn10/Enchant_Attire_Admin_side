import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  
  var profileImagePath = ''.obs;
  var profileImageLink = '';

  var isLoading = false.obs;

  var nameEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  var newpassEditingController = TextEditingController();

  changeImage(context) async{
    try {
          final img = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 100);
    if (img == null) return;
    profileImagePath.value = img.path;
    } on PlatformException catch(e) {
      VxToast.show(context, msg: e.toString());
    }

  }

  uploadProfileImage() async{
    var filename = basename(profileImagePath.value);
    var destination = 'images/${currentUser!.email}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateprofile({username,password,imgUrl,}) async{
    var store = firestore.collection('vendors').doc(currentUser!.uid);
    await store.set({
      "username":username,
      //'password':password,
      "imageUrl":imgUrl,
    },SetOptions(merge: true));
    isLoading(false);

  }
 
}
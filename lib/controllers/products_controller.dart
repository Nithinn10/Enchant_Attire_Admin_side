import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:enchant_attire_admin/Models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import '../consts/consts.dart';
import 'package:image_picker/image_picker.dart';
class ProductsController extends GetxController {

  var isLoading=false.obs;

  var pnameController = TextEditingController();
  var descController = TextEditingController();
  var price = TextEditingController();
  var inBagController = TextEditingController();
  var qtyController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;

  Future<void> getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  void populateCategoryList() {
    categoryList.clear();

    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  void populateSubcategoryList(String cat) {
    subcategoryList.clear();

    var data = category.where((element) => element.name == cat).toList();

    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index,context)async{

    try {
      final img =  await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 100);
      if(img == null){
        return;
      }else{
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }

  }

  uploadImages()async{
    pImagesLinks.clear();
    for(var item in pImagesList){
      if(item!=null){
    var filename = basename(item.path);
    var destination = 'images/products${currentUser!.email}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(item);
    var n = await ref.getDownloadURL();
    pImagesLinks.add(n);
  }
      }
    }

  uploadProduct(context) async{
    var store = firestore.collection('products').doc();
    await store.set({
      'is_featured':false,
      'pro_category':categoryvalue.value,
      'p_subcategory': subcategoryvalue.value,
      'p_images':FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist':FieldValue.arrayUnion([]),
      'pro-des':descController.text,
      'p_name':pnameController.text,
      'price':price.text,
      'quantity':qtyController.text,
      'size_m':"Medium",
      'size_s':"Small",
      'customize':"Customize",
      'vendor_id':currentUser!.uid,
      'pro_details':inBagController.text,
      'p_seller':"Enchant Attire",
      'pro_rating':'5.0',
      //'featured_id':''
    }
    );
    isLoading(false);
    VxToast.show(context, msg: "Product uploaded");
  }

  removeProduct(docId) async{
    await firestore.collection(productsCollection).doc(docId).delete();
  }

  }





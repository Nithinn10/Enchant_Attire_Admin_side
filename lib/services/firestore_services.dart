import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get_connect/http/src/utils/utils.dart';

//users data
// class FirestoreServices {
//   static getUser(uid) {
//     return firestore
//         .collection(usersCollection)
//         .where('id', isEqualTo: uid)
//         .snapshots();
//   }

//   // fetch products

//   static getProducts(category) {
//     return firestore
//         .collection(productsCollection)
//         .where('pro_category', isEqualTo: category)
//         .snapshots();
//   }

//   // get carts

//   static getCart(uid) {
//     return firestore
//         .collection('cartCollection')
//         .where('added_by', isEqualTo: uid)
//         .snapshots();
//   }

//   // delete item in cart

//   static deleteDocument(docId) {
//     return firestore.collection('cartCollection').doc(docId).delete();
//   }

// //get chats
//   static getChatMessages(docId) {
//     return firestore
//         .collection(chatsCollection)
//         .doc(docId)
//         .collection(messageCollection)
//         .orderBy('created_on', descending: false)
//         .snapshots();
//   }

//   //
//  static Stream<QuerySnapshot> getAddress(String uid) {
//     return FirebaseFirestore.instance
//         .collection('address')
//         .where('userId', isEqualTo: uid)
//         .snapshots();
//   }
//  static getAllOrders(){
//   return firestore.collection('orders').where('ordered_by', isEqualTo: currentUser!.uid).snapshots();
//  }
//   static getWishlist(uid){
//   return firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).snapshots();
//  }


// }

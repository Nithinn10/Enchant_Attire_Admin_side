import 'package:enchant_attire_admin/consts/consts.dart';

class StoreServices {
  static getProfile(uid){
    return firestore.collection('vendors').where('id',isEqualTo: uid).get();
  }

static getMessags(uid){
  return firestore.collection('chats').where('toId', isEqualTo: uid).snapshots();
}
static getOrders(uid) {
  return firestore.collection('ordered Item').where('vendor_id', isEqualTo: uid).snapshots();
}


static getProducts(uid){
  return firestore.collection(productsCollection).where("vendor_id", isEqualTo: uid).snapshots();
 
}

  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }


// static getPopularProducts(uid){
//   return firestore.collection('products').where('vendor_id',isEqualTo: uid).orderBy('p_wishlist'.length);
// }
  
}
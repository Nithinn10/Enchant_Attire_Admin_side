import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../consts/consts.dart';

class AuthController extends GetxController{
  //isLoading = false.obs;
  TextEditingController usercontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
   //FirebaseAuth auth = FirebaseAuth.instance;
  Rx<User?> currentUser = Rx<User?>(null); // Hold the current user
  

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserCredential?> loginMethod({String? email, String? password, BuildContext? context}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: usercontroller.text!, password: passcontroller.text!);
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (context != null) {
        VxToast.show(context, msg: e.message ?? "An error occurred during login.");
      }
      return null;
    }
  }
  Future<UserCredential?> signupMethod({String? email, String? password, BuildContext? context}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email!, password: password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (context != null) {
        VxToast.show(context, msg: e.message ?? "An error occurred during signup.");
      }
      return null;
    }
  }

Future<void> storeUserData({String? email, String? username, String? password, String? imageUrl}) async {
  User? currentUser = auth.currentUser;
  if (currentUser != null) {
    DocumentReference store = firestore.collection('vendors').doc(currentUser.uid);
    // Hash the password using hashCode
    String hashedPassword = password?.hashCode.toString() ?? '';
    await store.set({
      "username": username,
      'password': password,
      'email': email,
      'imageUrl': imageUrl ?? '',
      'id': currentUser.uid,
     
     
    });
  } else {
    print("User is null, cannot store user data.");
  }
}


  Future<void> signoutMethod(BuildContext? context) async {
    try {
      await auth.signOut();
       //exit(0);
      
    } catch (e) {
      if (context != null) {
        VxToast.show(context, msg: e.toString());
      }
    }
  }
}


  


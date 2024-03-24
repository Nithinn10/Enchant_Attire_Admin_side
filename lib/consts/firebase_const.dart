import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User ? currentUser = auth.currentUser;

// collections

const usersCollection = 'users';
const cartCollection = 'cartCollection';
const chatsCollection = 'chats';
const messageCollection = 'messages';
const productsCollection = 'products';
const ordersCollection = 'orders';
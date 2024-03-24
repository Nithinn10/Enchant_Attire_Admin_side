import 'package:enchant_attire_admin/Screens/Messages/chat_screen.dart';
import 'package:enchant_attire_admin/common_widgets/loadingIndicator.dart';
import 'package:enchant_attire_admin/services/store_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;
import '../../consts/consts.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Messages".text.fontFamily(semibold).color(enchant).size(16).make(),
      ),
      body: StreamBuilder(
        stream: StoreServices.getMessags(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loadingIndicator());
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                   var t = data[index]['created_on'] == null ? DateTime.now() : data[index]['created_on'].toDate();
                   var time = intl.DateFormat('h:mma').format(t);
                    return
                    ListTile(
                    onTap: () {
                      Get.to(ChatScreen());
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person, color: whiteColor),
                    ),
                    title: "${data[index]['sender_name']}".text.fontFamily(semibold).color(Colors.black).size(14).make(),
                    subtitle: "${data[index]['last_msg']}".text.fontFamily(semibold).color(fontGrey).size(12).make(),
                    trailing: time.text.fontFamily(semibold).color(fontGrey).size(12).make(),
                  );
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

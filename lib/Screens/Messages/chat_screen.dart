import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Chat screen".text.make(),
      ),
      body:Column(
        children: [
          Expanded(child: Container(
            color: Colors.teal,
          )),

        ],
      )
    );
  }
}
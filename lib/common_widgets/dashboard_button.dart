import 'package:flutter/material.dart';


import '../consts/consts.dart'; // Import the supercharged library

Widget dashboardButton({BuildContext? context, required String title, required String count, icon}) {
  var size = MediaQuery.of(context!).size;
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            title.text.fontFamily(semibold).color(Colors.white).size(14).make(), // Apply text styling using .text
            count.text.fontFamily(semibold).color(Colors.white).size(12).make(), // Apply text styling using .text

          ],
        ),
      ),
      Image.asset(icon,width: 40,color: whiteColor,)
    ],
  ).box.color(enchant).rounded.size(size.width * 0.4, 80).padding(EdgeInsets.all(12)).make();
}

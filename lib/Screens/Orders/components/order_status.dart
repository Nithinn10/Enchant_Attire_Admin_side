
import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:flutter/material.dart';

Widget orderStatus({icon, color, title, showDone}){
  return ListTile(
    leading: Icon(icon,color: color,).box.border(color: color).roundedSM.padding(EdgeInsets.all(6)).make(),

    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        "${title}".text.fontFamily(semibold).color(fontGrey).make(),
        showDone ?
       Icon(Icons.done,color: redColor,)
       //.box.border(color: enchant).make()
       :Container(),
        
      ],),
    ),
  );
}
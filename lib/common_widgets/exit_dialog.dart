
import 'package:flutter/services.dart';

import '../consts/consts.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(14).color(Colors.black).make(),
        Divider(),
        10.heightBox,
        'Are you sure you want to exit'.text.fontFamily(bold).size(12).color(Colors.black).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          ElevatedButton(onPressed: (){
           
            SystemNavigator.pop();
          }, 
          style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
          
          child: Text('Yes', style: TextStyle(color: Colors.black),)),
           ElevatedButton(onPressed: (){
               Navigator.pop(context);
          }, 
          style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
          
          child: Text('No', style: TextStyle(color: Colors.black),)),
        ],)

      ],
    ).box.color(Colors.white).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}
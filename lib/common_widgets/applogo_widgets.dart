import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart'; 


import '../consts/consts.dart';
Widget appLogoWidget() {
  return Image.asset(offllogo).box.white.size(230, 230).padding(const EdgeInsets.all(8)).rounded.make();
}
//change the caption from the logo

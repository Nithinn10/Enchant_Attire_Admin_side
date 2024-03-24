import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/images.dart'; 


Widget appLogoAuthWidget() {
  return Image.asset(offllogo).box.white.size(150, 150).padding(const EdgeInsets.all(8)).rounded.make();
}
//change the caption from the logo

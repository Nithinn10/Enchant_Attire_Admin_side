import 'package:enchant_attire_admin/consts/consts.dart';

Widget productImages({required label, onPress}){
  return "$label".text.fontFamily(semibold).makeCentered().box.color(const Color.fromARGB(255, 165, 165, 165)).size(100,100).roundedSM.make();
}
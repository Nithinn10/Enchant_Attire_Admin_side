import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:intl/intl.dart';
import 'normalText.dart';


Widget appBarWidget(title,){
    String formattedDate = DateFormat.yMMMMd().format(DateTime.now());
  return  AppBar(
        title: "title".text.fontFamily(semibold).color(enchant).size(16).make(),
        actions: [
          normalText(text: formattedDate, color: enchant,),10.widthBox
        ],
      );
 
}
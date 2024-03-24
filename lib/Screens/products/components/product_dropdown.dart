import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:enchant_attire_admin/controllers/products_controller.dart';
import 'package:get/get.dart';

Widget productDropdown(String hint, List<String> list, dropValue, ProductsController controller) {
  return Obx(()=>
     DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: Text(hint), // Wrap hint text in a Text widget
        value: dropValue == '' ? null : dropValue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            child: Text(e),
            value: e,
          );
        }).toList(),
        onChanged: (newValue) {
          if (hint == "Category") {
            controller.subcategoryvalue.value = '';
            controller.populateSubcategoryList(newValue.toString());
          }
          dropValue.value = newValue.toString();
        },
      ),
    ).box.white.padding(EdgeInsets.symmetric(horizontal: 4)).roundedSM.make(),
  );
}

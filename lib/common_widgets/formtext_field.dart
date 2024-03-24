import 'package:enchant_attire_admin/consts/consts.dart';


Widget FormTextField({label,hint,controller,isDesc = false}){
  return TextFormField(
    controller: controller,
    maxLines: isDesc ? 2 : 1,
    decoration: InputDecoration(
      isDense: true,
      label: Text(label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.white,
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: enchant
        )
      ),
      hintText: hint,
      hintStyle: const TextStyle(color: whiteColor)
    ),
  );
}
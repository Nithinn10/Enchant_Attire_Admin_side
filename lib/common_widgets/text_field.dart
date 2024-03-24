import 'package:flutter/material.dart';

class AddressTextField extends StatelessWidget {
  final String hint;
  final String title;
  //final TextEditingController controller;


  const AddressTextField({
    Key? key,
    required this.hint,
    required this.title,
    //required this.controller,

   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      //controller: controller,
      decoration: InputDecoration(
        
        labelText: title,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

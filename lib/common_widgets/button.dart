
import 'package:flutter/material.dart';

import '../consts/consts.dart';

Widget CustomButton(
    BuildContext context, double textFieldWidth, String buttonText,
    {required VoidCallback onPressed}) {
  return Container(
    width: textFieldWidth,
    height: MediaQuery.of(context).size.height * 0.06,
    margin: const EdgeInsets.symmetric(horizontal: 12.0),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: enchant,
        minimumSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

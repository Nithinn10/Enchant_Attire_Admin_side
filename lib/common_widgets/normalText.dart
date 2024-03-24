import 'package:flutter/material.dart';

import '../consts/consts.dart';

class normalText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  

  const normalText({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.size = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: semibold,
        color: color,
        fontSize: size,
      ),
    );
  }
}


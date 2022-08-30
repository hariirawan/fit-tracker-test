import 'package:flutter/material.dart';

ButtonStyle btnStyle() {
  return ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      minimumSize: MaterialStateProperty.all(Size(Size.infinite.width, 50)),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      backgroundColor: MaterialStateProperty.all(Colors.green));
}

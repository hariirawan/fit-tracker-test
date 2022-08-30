import 'package:flutter/material.dart';

InputDecoration decorationTextfield({String? hintText}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.green),
    fillColor: const Color(0xFFE7F7E4),
    filled: true,
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    required Color color,
    required double textSize,
    IconData? prefixIcon,
  }){
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: color, fontSize: textSize) ,
      labelText: labelText,
      labelStyle: TextStyle(color: color, fontSize: textSize),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      prefixIconColor: color,
    );
  }
}
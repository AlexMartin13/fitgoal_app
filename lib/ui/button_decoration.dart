import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class ButtonDecorations {
  static MaterialButton buttonDecoration({
    required String textButton,
    required Color textColor,
    required Color textStrokeColor,
    required Color borderButtonColor,
    required Color buttonColor,
    required VoidCallback function,
  }) {
    return MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: borderButtonColor,
          ),
        ),
        disabledColor: buttonColor,
        elevation: 0,
        color: buttonColor,
        onPressed: function,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
          child: StrokeText(
            text: textButton,
            textStyle: TextStyle(color: textColor, fontSize: 15),
            strokeColor: textStrokeColor,
            strokeWidth: 5,
          ),
        ));
  }
}

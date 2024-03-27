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
    double? textSize,
    double? buttonHorizontalPadding,
    double? buttonVerticalPadding
  }) {
    textSize ??= 15;
    buttonHorizontalPadding ??= 60;
    buttonVerticalPadding ??= 15;
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
          padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding, vertical: buttonVerticalPadding),
          child: StrokeText(
            text: textButton,
            textStyle: TextStyle(color: textColor, fontSize: textSize),
            strokeColor: textStrokeColor,
            strokeWidth: 5,
          ),
        ));
  }
}

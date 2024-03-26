import 'package:flutter/material.dart';

AppBar appBarFitGoal() {
  return AppBar(
    backgroundColor: Color.fromRGBO(114, 191, 1, 1),
    toolbarHeight: 120,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Transform.scale(
            scale: 5,
            child: Image(image: AssetImage('assets/png_icons/logo.png'), height: 25,)
          ),
        )
      ],
    ),
  );
}
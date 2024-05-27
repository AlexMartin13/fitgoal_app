import 'package:flutter/material.dart';

AppBar appBarFitGoalComplete() {
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

AppBar reducedAppBar(BuildContext context, String previousRoute) {
  return AppBar(
        backgroundColor: const Color.fromRGBO(114, 191, 1, 1),
        leading: GestureDetector(
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: ImageIcon(
              AssetImage('assets/png_icons/back_arrow.png'),
              color: Colors.white,
            ),
          ),
          onTap: () {
            if(previousRoute == 'exercices' || previousRoute == 'sessions'){
              Navigator.pop(context);
            }else{
              Navigator.pushNamed(context, previousRoute);
            }
          },
        ),
      );
}



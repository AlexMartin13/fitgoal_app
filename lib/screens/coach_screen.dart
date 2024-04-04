import 'package:fitgoal_app/ui/button_decoration.dart';
import 'package:flutter/material.dart';

class CoachMenu extends StatefulWidget {
  const CoachMenu({super.key});

  @override
  State<CoachMenu> createState() => _CoachMenuState();
}

class _CoachMenuState extends State<CoachMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            _playersBtn(),
            SizedBox(height: 120),
            _lineUpBtn(),
            SizedBox(height: 120),
            _boardBtn(),
          ],
        ),
      ),
    );
  }

  Widget _playersBtn() {
    return ButtonDecorations.buttonDecoration(
        textButton: 'JUGADORES',
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        buttonHorizontalPadding: 90,
        buttonVerticalPadding: 20,
        textSize: 20,
        function: () {});
  }

  Widget _lineUpBtn() {
        return ButtonDecorations.buttonDecoration(
        textButton: 'ALINEACIÓN',
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        buttonHorizontalPadding: 90,
        buttonVerticalPadding: 20,
        textSize: 20,
        function: () {});
  }

    Widget _boardBtn() {
        return ButtonDecorations.buttonDecoration(
        textButton: 'PIZARRA',
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        buttonHorizontalPadding: 105,
        buttonVerticalPadding: 20,
        textSize: 20,
        function: () {});
  }
}

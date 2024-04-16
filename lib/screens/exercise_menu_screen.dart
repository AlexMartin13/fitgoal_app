import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/ui/button_decoration.dart';
import 'package:flutter/material.dart';

class ExerciseMenu extends StatefulWidget {
  const ExerciseMenu({super.key});

  @override
  State<ExerciseMenu> createState() => _ExerciseMenuState();
}

class _ExerciseMenuState extends State<ExerciseMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 80),
              _mySessionsBtn(),
              SizedBox(height: 120),
              _exercisesBtn(),
              SizedBox(height: 120),
              _chronoBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mySessionsBtn() {
    return ButtonDecorations.buttonDecoration(
        textButton: 'MIS SESIONES',
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        buttonHorizontalPadding: 80,
        buttonVerticalPadding: 20,
        textSize: 20,
        function: () {
          print(LoginService.token);
        });
  }

  Widget _exercisesBtn() {
    return ButtonDecorations.buttonDecoration(
        textButton: 'EJERCICIOS',
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        buttonHorizontalPadding: 93,
        buttonVerticalPadding: 20,
        textSize: 20,
        function: () {
          Navigator.pushNamed(context, 'exercices');
        });
  }

  Widget _chronoBtn() {
    return ButtonDecorations.buttonDecoration(
        textButton: 'CRONÓMETRO',
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        buttonHorizontalPadding: 79,
        buttonVerticalPadding: 20,
        textSize: 20,
        function: () {});
  }
}

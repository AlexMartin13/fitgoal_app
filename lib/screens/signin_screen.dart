import 'package:fitgoal_app/ui/button_decoration.dart';
import 'package:fitgoal_app/ui/input_decoration.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(114, 191, 1, 1),
        leading: GestureDetector(
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: ImageIcon(
              AssetImage('assets/png_icons/back_arrow.png'),
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, '/');
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: SingleChildScrollView(
        child: _SignInBlock(),
      ),
    );
  }
}

Column _SignInBlock() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  color: const Color.fromRGBO(114, 191, 1, 1), width: 1.5),
            ),
            child: Container(
              width: 310,
              height: 370,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _SignInForm(),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: _SignInBtn(),
      )
    ],
  );
}

class _SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                return value!.length > 0
                    ? null
                    : 'No se permiten campos vacios';
              },
              autocorrect: false,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'John Doe',
                  labelText: 'Nombre',
                  color: Colors.white,
                  textSize: 15,
                  prefixIcon: Icons.person),
            ),
            TextFormField(
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Introduce un email valido';
              },
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'EMAIL',
                prefixIcon: Icons.alternate_email_sharp,
                color: Colors.white,
                textSize: 15,
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'La contraseña debe contener al menos 6 caracteres';
                }
                return null;
              },
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Contraseña',
                labelText: 'CONTRASEÑA',
                prefixIcon: Icons.lock,
                color: Colors.white,
                textSize: 15,
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'La contraseña debe contener al menos 6 caracteres';
                }
                return null;
              },
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Contraseña',
                labelText: 'REPITE CONTRASEÑA',
                prefixIcon: Icons.lock,
                color: Colors.white,
                textSize: 15,
              ),
            ),
            SizedBox(height: 30),
          ],
        ));
  }
}

class _SignInBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonDecorations.buttonDecoration(
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        textButton: "REGISTRARSE",
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        function: () {
          Navigator.pushReplacementNamed(context, 'home');
        });
  }
}

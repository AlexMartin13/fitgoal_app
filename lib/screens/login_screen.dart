import 'package:fitgoal_app/ui/button_decoration.dart';
import 'package:fitgoal_app/ui/input_decoration.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarFitGoal(),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: SingleChildScrollView(
        child: _LoginBlock(context),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
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
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Contraseña',
                  labelText: 'CONTRASEÑA',
                  prefixIcon: Icons.lock,
                  color: Colors.white,
                  textSize: 15,
                ),
              ),
              SizedBox(height: 30),
            ],
          )),
    );
  }
}

class _LoginBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonDecorations.buttonDecoration(
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        textButton: "INICIAR SESIÓN",
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        function: () {
          Navigator.pushReplacementNamed(context, 'home');
        });
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonDecorations.buttonDecoration(
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        textButton: "CREAR CUENTA",
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        function: () {
          Navigator.pushReplacementNamed(context, 'register');
        });
  }
}

TextButton _ForgotPass(BuildContext context) {
  return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, 'recover');
      },
      child: Text(
        "¿HAS OLVIDADO TU CONTRASEÑA?",
        style: TextStyle(
          color: Colors.white,
        ),
      ));
}

Column _LoginBlock(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  color: const Color.fromRGBO(114, 191, 1, 1), width: 1.5),
            ),
            child: Container(
              width: 310,
              height: 350,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _LoginForm(),
                  const SizedBox(height: 20),
                  _LoginBtn(),
                  const SizedBox(height: 10),
                  _ForgotPass(context)
                ],
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 30),
        child: _SignInButton(),
      )
    ],
  );
}

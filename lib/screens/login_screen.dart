import 'package:flutter/services.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/ui/button_decoration.dart';
import 'package:fitgoal_app/ui/input_decoration.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginService = new LoginService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarFitGoalComplete(),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: SingleChildScrollView(
        child: _LoginBlock(context),
      ),
    );
  }

  Widget _LoginForm() {
    return Container(
      child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              _email(),
              _password(),
              SizedBox(height: 30),
            ],
          )),
    );
  }

  Widget _LoginBtn() {
    return ButtonDecorations.buttonDecoration(
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        textButton: "INICIAR SESIÓN",
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        function: () async {
          if (_formKey.currentState?.validate() == true) {
            Map<String, dynamic> credentials = {
              'email': loginService.email,
              'password': loginService.password,
            };

            try {
              await loginService.signIn(credentials);
              if (!mounted) return;
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('home', (route) => false);
            } catch (error) {
              if (!mounted) return;
              print("error: $error");
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Credenciales no válidas'),
                      content:
                          Text('Las credenciales introducidas son incorrectas'),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Ok'))
                      ],
                    );
                  });
            }
          }
        });
  }

  Widget _SignInButton() {
    return ButtonDecorations.buttonDecoration(
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        textButton: "CREAR CUENTA",
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        function: () {
          Navigator.pushNamed(context, 'register');
        });
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
                height: 380,
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

  TextFormField _email() {
    return TextFormField(
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
      onChanged: (value) => loginService.email = value,
      validator: (value) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value ?? '')
            ? null
            : 'Introduce un email valido';
      },
    );
  }

  TextFormField _password() {
    return TextFormField(
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
      onChanged: (value) => loginService.password = value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.length < 6) {
          return 'La contraseña debe contener al menos 6 caracteres';
        }
        return null;
      },
    );
  }
}

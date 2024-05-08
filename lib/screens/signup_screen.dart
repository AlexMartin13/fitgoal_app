import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/services/user_service.dart';
import 'package:fitgoal_app/ui/button_decoration.dart';
import 'package:fitgoal_app/ui/input_decoration.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _surnames = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  UserService userService = new UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reducedAppBar(context, '/'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: SingleChildScrollView(
        child: _SignInBlock(),
      ),
    );
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
                height: 550,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    _SignInForm(),
                    const SizedBox(height: 30),
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

  Widget _SignInForm() {
    return Form(
      key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            _Name(),
            _Surnames(),
            _Email(),
            SizedBox(
              height: 20,
            ),
            _Password(),
            SizedBox(
              height: 20,
            ),
            _RepeatPassword(),
            SizedBox(height: 30),
          ],
        ));
  }

  Widget _SignInBtn() {
    return ButtonDecorations.buttonDecoration(
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        textButton: "REGISTRARSE",
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        function: () async {
          if (_formKey.currentState?.validate() == true) {
            if (_password != _confirmPassword) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Error al registrarse'),
                      content: Text('Las contraseñas no coinciden'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'),
                        ),
                      ],
                    );
                  });
            } else {
              Map<String, dynamic> credentials = {
                "name": _name,
                "surname": _surnames,
                "email": _email,
                "password": _password,
                "roles": ["ROLE_USER"]
              };
              try {
                await userService.signUpUser(credentials); //We sign up
                Map<String, dynamic> credentialsLogin = {
                  //Save the credentials to login
                  "email": _email,
                  "password": _password,
                };
                await LoginService().signIn(credentialsLogin);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('home', (route) => false);
              } catch (error) {
              }
            }
          }
        });
  }

  Widget _Name() {
    return TextFormField(
      maxLength: 25,
      autocorrect: false,
      keyboardType: TextInputType.name,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecorations.authInputDecoration(
        hintText: 'John',
        labelText: 'NOMBRE',
        color: Colors.white,
        textSize: 15,
        prefixIcon: Icons.person,
      ),
      onChanged: (value) => setState(() {
        _name = value;
      }),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value!.isNotEmpty ? null : 'No se permiten campos vacios';
      },
    );
  }

  TextFormField _Surnames() {
    return TextFormField(
      maxLength: 50,
      validator: (value) {
        return value!.isNotEmpty ? null : 'No se permiten campos vacios';
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autocorrect: false,
      keyboardType: TextInputType.name,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecorations.authInputDecoration(
        hintText: 'Doe',
        labelText: 'APELLIDOS',
        color: Colors.white,
        textSize: 15,
        prefixIcon: Icons.person,
      ),
      onChanged: (value) => setState(() {
        _surnames = value;
      }),
    );
  }

  TextFormField _Email() {
    return TextFormField(
      validator: (value) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value ?? '')
            ? null
            : 'Introduce un email valido';
      },
      autocorrect: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecorations.authInputDecoration(
        hintText: 'john.doe@gmail.com',
        labelText: 'EMAIL',
        prefixIcon: Icons.alternate_email_sharp,
        color: Colors.white,
        textSize: 15,
      ),
      onChanged: (value) => setState(() {
        _email = value;
      }),
    );
  }

  TextFormField _Password() {
    return TextFormField(
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
      onChanged: (value) => setState(() {
        _password = value;
      }),
    );
  }

TextFormField _RepeatPassword() {
  return TextFormField(
    validator: (value) {
      if (value == null || value != _password) {
        return 'Las contraseñas no coinciden';
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
    onChanged: (value) => setState(() {
      _confirmPassword = value;
    }),
  );
}

}

import 'package:fitgoal_app/ui/button_decoration.dart';
import 'package:fitgoal_app/ui/input_decoration.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: SingleChildScrollView(
        child: _RecoverBlock(context),
      ),
    );
  }
}

Column _RecoverBlock(BuildContext context) {
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
                  SizedBox(height: 30),
                  _RecoverText(),
                  SizedBox(
                    height: 20,
                  ),
                  _RecoverEmailField(),
                  SizedBox(height: 50),
                  _SendBtn()
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class _SendBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonDecorations.buttonDecoration(
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        textButton: "RESTABLECER CONTRASEÑA",
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        textSize: 15,
        buttonHorizontalPadding: 10,
        function: () {
          Navigator.pop(context);
        });
  }
}

class _RecoverText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Introduce el correo eléctronico, si corresponde a una cuenta"
        " nuestra, se le enviará un correo electrónico con una nueva",
        textScaler: TextScaler.linear(1),
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _RecoverEmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        decoration: InputDecorations.authInputDecoration(
            hintText: 'johndoe@email.com',
            labelText: 'Correo electrónico',
            color: Colors.white,
            textSize: 20),
      ),
    );
  }
}

import 'package:fitgoal_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/widgets/appbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);
    final userService = Provider.of<UserService>(context);
    return Scaffold(
      appBar: reducedAppBar(context, 'sessions'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Contraseña actual: ',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white), // Texto blanco
                      obscureText: true,
                      validator: (value) {
                        if (value != loginService.password) {
                          return "Contraseña actual incorrecta";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(
                        labelText: "Nueva contraseña",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white), // Texto blanco
                      obscureText: true,
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value == null ||
                            value.length < 6 ||
                            value.isEmpty) {
                          return "La contraseña debe contener al menos 6 caracteres";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _confirmPassController,
                      decoration: InputDecoration(
                        labelText: "Confirmar nueva contraseña",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white), // Texto blanco
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value != _passController.text) {
                          return "Las contraseñas no coinciden";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        // Aquí deberías ver la contraseña actual
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            await userService.changePassword(
                                {"password": _passController.text},
                                LoginService.id);
                                loginService.password = _passController.text;
                                ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Contraseña cambiada')));
                                Navigator.pop(context);
                          } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al cambiar la contraseña ' + error.toString())));
                          }
                        }
                      },
                      child: Text("Cambiar contraseña"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

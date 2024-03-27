import 'dart:convert';
import 'package:fitgoal_app/helpers/debouncer.dart';
import 'package:fitgoal_app/models/models.dart';
import 'package:fitgoal_app/provider/fitgoal_provider.dart';
import 'package:flutter/material.dart';


class LoginService extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  static LoggedUser user = LoggedUser.empty();

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  bool isLoadingForgotPassword = false;

Future<bool> signIn(Map<String, dynamic> data) async {
  try {
    final jsonData = await FitGoalProvider.postJsonData('/api/auth/signin/user', data);
    print(jsonData);
    user = LoggedUser.fromJson(json.decode(jsonData));
    if (user.token.isNotEmpty) { 
      FitGoalProvider.apiKey = '${user.type} ${user.token}';
      notifyListeners();
      return true;
    }
    return false;
  } catch (e) {
    print(e); 
    return false;
  }
}

  bool isValidForm() {
    print('$email - $password');
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}
import 'dart:convert';
import 'package:fitgoal_app/helpers/debouncer.dart';
import 'package:fitgoal_app/main.dart';
import 'package:fitgoal_app/models/models.dart';
import 'package:fitgoal_app/provider/fitgoal_provider.dart';
import 'package:fitgoal_app/services/team_service.dart';
import 'package:flutter/material.dart';


class LoginService extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  static LoggedUser user = LoggedUser.empty();
  static String token = '';
  static int id = 0;


  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  bool isLoadingForgotPassword = false;


  signIn(Map<String, dynamic> data) async {
    final jsonData = await FitGoalProvider.postJsonData('api/auth/signin/user', data);
    user = LoggedUser.fromJson(json.decode(jsonData));
    FitGoalProvider.apiKey = '${user.type} ${user.token}';
    id = user.id;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

}
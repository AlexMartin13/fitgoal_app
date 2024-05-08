import 'dart:convert';
import 'package:fitgoal_app/models/models.dart';
import 'package:fitgoal_app/provider/fitgoal_provider.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier{
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  String name = '';
  String surnames = '';
  String email = '';
  String password = '';

  User user = new User.empty();

    signUpUser(Map<String, dynamic> data) async {
    final jsonData = await FitGoalProvider.postJsonData('api/auth/signup/user', data);
    user = User.fromJson(json.decode(jsonData));
    notifyListeners();
  } 
}
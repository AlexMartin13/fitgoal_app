import 'dart:async';
import 'dart:convert';

import 'package:fitgoal_app/helpers/debouncer.dart';
import 'package:fitgoal_app/provider/fitgoal_provider.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class ExerciceService extends ChangeNotifier {
  List<Exercice> exercices = [];
  Exercice exercice = Exercice.empty();

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));
  final StreamController<List<Exercice>> _suggestionStreamController = StreamController.broadcast();

  Stream<List<Exercice>> get suggestionStream => _suggestionStreamController.stream;

  Future<void> getExercices() async{
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';
    print(FitGoalProvider.apiKey);

    if(user != null){
      final jsonData = await FitGoalProvider.getJsonData(
        'exercice'
      );

      final List<dynamic> jsonList = json.decode(jsonData);
      exercices = Exercice.fromJsonList(jsonList);
      print(jsonList);
      notifyListeners();
    }
  }
  
}

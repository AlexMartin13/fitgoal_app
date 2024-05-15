import 'dart:async';
import 'dart:convert';
import 'package:fitgoal_app/helpers/debouncer.dart';
import 'package:fitgoal_app/provider/fitgoal_provider.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class ExerciceService extends ChangeNotifier {
  List<Exercice> exercices = [];
  List<Exercice> exercicesInSession = [];
  Exercice exercice = Exercice.empty();

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));
  final StreamController<List<Exercice>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<List<Exercice>> get suggestionStream =>
      _suggestionStreamController.stream;

  Future<void> getExercices() async {
    if (exercices.isNotEmpty) exercices.clear();
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';

    final jsonData = await FitGoalProvider.getJsonData('exercice');

    final List<dynamic> jsonList = json.decode(jsonData);
    exercices = Exercice.fromJsonList(jsonList);
    notifyListeners();
    }

  Future<void> getExercicesFromSession(int id) async {
      exercicesInSession = [];
      final user = LoginService.user;
      FitGoalProvider.apiKey = '${user.type} ${user.token}';

      final jsonData =
          await FitGoalProvider.getJsonData('exercice/session/$id');
      final List<dynamic> jsonList = json.decode(jsonData);
      exercicesInSession = Exercice.fromJsonList(jsonList);
      notifyListeners();
      }

  Future<void> addExerciceIntoSession(
      Exercice exercice, Session session) async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';
    var data = {"exerciceId": exercice.id, "sessionId": session.id};
    await FitGoalProvider.postJsonData(
      'exercice/session',
      data,
    );

    notifyListeners();
    }

  Future<void> createExercice(Map<String, dynamic> data) async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';

    await FitGoalProvider.postJsonData('exercice', data);
    notifyListeners();
    }

  Future<void> removeExerciceFromSession(
      Exercice exercice, Session session) async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';
    var data = {"exerciceId": exercice.id, "sessionId": session.id, "addedAt": exercice.addedAt};
    await FitGoalProvider.deleteJsonDataWithBody(
      'exercice/session',
      data,
    );

    notifyListeners();
    }
}

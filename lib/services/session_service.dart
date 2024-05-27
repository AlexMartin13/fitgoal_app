import 'dart:async';
import 'dart:convert';

import 'package:fitgoal_app/helpers/debouncer.dart';
import 'package:fitgoal_app/models/session.dart';
import 'package:fitgoal_app/provider/fitgoal_provider.dart';
import 'package:fitgoal_app/services/exercice_service.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class SessionService extends ChangeNotifier {
  List<Session> sessions = [];
  Session session = Session.empty();
  Session newSession = Session.empty();
  String firstImage = '';

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));
  final StreamController<List<Session>> _suggestionStreamController = StreamController.broadcast();
  final ExerciceService exerciceService = ExerciceService();

  Stream<List<Session>> get suggestionStream => _suggestionStreamController.stream;

  Future<void> getSessions() async{
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';

    if(user != null){
      final jsonData = await FitGoalProvider.getJsonData(
        'session/creator-id/${user.id}'
      );

      final List<dynamic> jsonList = json.decode(jsonData);
      sessions = Session.fromJsonList(jsonList);

      for (var session in sessions) {
        final jsonData =
            await FitGoalProvider.getJsonData('exercice/session/${session.id}');
        final List<dynamic> jsonListExercice = json.decode(jsonData);
        List<Exercice> exercices = Exercice.fromJsonList(jsonListExercice);
        session.exercices = exercices;
      }
      notifyListeners();
    }
  }

Future<String>? getSessionFirstExerciceImage(int sessionId) async{
  final user = LoginService.user;
  FitGoalProvider.apiKey = '${user.type} ${user.token}';

    final jsonData = await FitGoalProvider.getJsonData(
      'session/image/${sessionId}'
    );
    final List<dynamic> jsonList = json.decode(jsonData);
    final firstImage = jsonList.isNotEmpty ? jsonList[0]["image"] : '';
    notifyListeners();
    return firstImage;
}


  Future<void> createSession(Map<String, dynamic> data) async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';

    if(user != null){
      await FitGoalProvider.postJsonData('session/${user.id}', data);
      notifyListeners();
    }
  }

  Future<void> deleteSession(int sessionId) async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';

    if(user != null){
      await FitGoalProvider.deleteJsonData('session/$sessionId');
      notifyListeners();
    }
  }
}

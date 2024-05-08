import 'dart:async';
import 'dart:convert';

import 'package:fitgoal_app/helpers/debouncer.dart';
import 'package:fitgoal_app/models/session.dart';
import 'package:fitgoal_app/provider/fitgoal_provider.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class SessionService extends ChangeNotifier {
  List<Session> sessions = [];
  Session session = Session.empty();
  Session newSession = Session.empty();

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));
  final StreamController<List<Session>> _suggestionStreamController = StreamController.broadcast();

  Stream<List<Session>> get suggestionStream => _suggestionStreamController.stream;

  Future<void> getSessions() async{
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';
    print(FitGoalProvider.apiKey);

    if(user != null){
      final jsonData = await FitGoalProvider.getJsonData(
        'session/creator-id/${user.id}'
      );

      final List<dynamic> jsonList = json.decode(jsonData);
      sessions = Session.fromJsonList(jsonList);
      print(jsonList);
      notifyListeners();
    }
  }

  Future<void> createSession(Map<String, dynamic> data) async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';
    print(FitGoalProvider.apiKey);

    if(user != null){
      final jsonData = await FitGoalProvider.postJsonData('session/${user.id}', data);
      newSession = Session.fromRawJson(jsonData);
      notifyListeners();
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:fitgoal_app/helpers/debouncer.dart';
import 'package:fitgoal_app/models/models.dart';
import 'package:fitgoal_app/provider/fitgoal_provider.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:flutter/material.dart';

class TagService extends ChangeNotifier{
  List<Tag> tags = [];
  Tag tag = Tag.empty();
  
  final debouncer = Debouncer(duration: Duration(milliseconds: 500));
  final StreamController<List<Tag>> _suggestionStreamController = StreamController.broadcast();

  Stream<List<Tag>> get suggestionStream => _suggestionStreamController.stream;

  
  Future<void> getTagsByExercice(int id) async{
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';
    print(FitGoalProvider.apiKey);

    if(user != null){
      final jsonData = await FitGoalProvider.getJsonData(
        'tag/exercice/$id'
      );

      final List<dynamic> jsonList = json.decode(jsonData);
      tags = Tag.fromJsonList(jsonList);
      print(jsonList);
      notifyListeners();
    }
  }
}
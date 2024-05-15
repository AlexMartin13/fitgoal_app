import 'dart:convert';

import 'package:fitgoal_app/models/player.dart';
import 'package:fitgoal_app/models/team.dart';
import 'package:fitgoal_app/provider/fitgoal_provider.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/services/player_service.dart';
import 'package:flutter/foundation.dart';

class TeamService extends ChangeNotifier{
  List<Player> players = [];
  String image = "";
  int teamId = 0;

  Future<void> getTeamLoggedUser() async {
    Team team = Team.empty();
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';
    if (user != null) {
      final jsonData = await FitGoalProvider.getJsonData('team/user/${user.id}');
      final Map<String, dynamic> jsonList = json.decode(jsonData);
      team.crest = jsonList['crest'];
      team.name = jsonList['name'];
      image = team.crest;
      teamId = jsonList['id'];
    }
    notifyListeners();
  }
}
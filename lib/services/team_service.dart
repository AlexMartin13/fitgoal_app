import 'dart:convert';

import 'package:fitgoal_app/models/player.dart';
import 'package:fitgoal_app/models/team.dart';
import 'package:fitgoal_app/provider/fitgoal_provider.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/services/player_service.dart';
import 'package:fitgoal_app/utils/utils.dart';
import 'package:flutter/foundation.dart';

class TeamService extends ChangeNotifier {
  List<Player> players = [];
  String image = "";
  int teamId = 0;
  List<Team> teams = [];

  Future<void> getTeamLoggedUser() async {
    print('patata');
    Team team = Team.empty();
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';
    final jsonData =
        await FitGoalProvider.getJsonData('team/user/${user.id}');
    final Map<String, dynamic> jsonList = json.decode(jsonData);
    team.name = jsonList['name'];
    if (jsonList['crest'] != null) {
      team.crest = jsonList['crest'];
      image = team.crest;
    }
    teamId = jsonList['id'];
    utils.teamId = teamId;
      notifyListeners();
  }

  Future<int> getTeamId() async {
    await getTeamLoggedUser();
    if (teamId != null) {
      return teamId;
    } else {
      teamId = 0;
      return teamId;
    }
  }

  Future<void> getAllTeams() async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';
    final jsonData = await FitGoalProvider.getJsonData('team');
    final List<dynamic> jsonList = json.decode(jsonData);
    teams = Team.fromJsonList(jsonList);
    notifyListeners();
  }

  linkUserTeam(int id, Map<String, dynamic> data) async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';
    await FitGoalProvider.postJsonData('staff', data);
    notifyListeners();
  }
}

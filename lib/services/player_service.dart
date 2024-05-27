import 'dart:convert';

import 'package:fitgoal_app/models/player.dart';
import 'package:fitgoal_app/provider/fitgoal_provider.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:flutter/foundation.dart';

class PlayerService extends ChangeNotifier {
  List<Player> players = [];

  Future<void> getPlayerByTeamId(int teamId) async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';

    if (user != null) {
      final jsonData =
          await FitGoalProvider.getJsonData('player/team/${teamId}');

      final List<dynamic> jsonList = json.decode(jsonData);
      players = Player.fromJsonList(jsonList);
      notifyListeners();
    }
  }

  Future<void> addPlayer(Map<String, dynamic> data) async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';

    await FitGoalProvider.postJsonData('player', data);
    notifyListeners();
  }

  Future<void> updatePlayer(int playerId, Map<String, dynamic> data) async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';

    await FitGoalProvider.putJsonData('player/$playerId', data);
    notifyListeners();
  }

  Future<void> deletePlayer(int id) async {
    final user = LoginService.user;
    FitGoalProvider.apiKey = '${user.type} ${user.token}';

    await FitGoalProvider.deleteJsonData('player/${id}');
    notifyListeners();
  }
}

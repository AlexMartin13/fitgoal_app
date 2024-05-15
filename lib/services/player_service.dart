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
      final jsonData = await FitGoalProvider.getJsonData('player/team/${teamId}');

      final List<dynamic> jsonList = json.decode(jsonData);
      players = Player.fromJsonList(jsonList);
      print(jsonList);
      notifyListeners();
    }
  }
}

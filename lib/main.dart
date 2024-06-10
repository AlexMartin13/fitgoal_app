import 'package:fitgoal_app/routes/routes.dart';
import 'package:fitgoal_app/services/exercice_service.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/services/player_service.dart';
import 'package:fitgoal_app/services/session_service.dart';
import 'package:fitgoal_app/services/tag_service.dart';
import 'package:fitgoal_app/services/team_service.dart';
import 'package:fitgoal_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const FitGoal());
}

class FitGoal extends StatelessWidget {
  const FitGoal();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => LoginService(),
          ),
          ChangeNotifierProvider.value(
            value: ExerciceService(),
          ),
          ChangeNotifierProvider.value(
            value: TagService(),
          ),
          ChangeNotifierProvider.value(
            value: SessionService(),
          ),
          ChangeNotifierProvider.value(
            value: TeamService(),
          ),
          ChangeNotifierProvider.value(
            value: PlayerService(),
          ),
          ChangeNotifierProvider.value(
            value: UserService(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: getApplicationRoutes(),
          initialRoute: '/',
        ));
  }
}

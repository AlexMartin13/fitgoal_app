import 'package:fitgoal_app/routes/routes.dart';
import 'package:fitgoal_app/services/exercice_service.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/services/tag_service.dart';
import 'package:flutter/material.dart';
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
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: getApplicationRoutes(),
          initialRoute: '/',
        ));
  }
}

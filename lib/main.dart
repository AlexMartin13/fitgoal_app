import 'package:fitgoal_app/routes/routes.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const FitGoal());
}

class FitGoal extends StatelessWidget{
  const FitGoal();

  @override
  Widget build(BuildContext context){
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LoginService()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: getApplicationRoutes(),
      initialRoute: '/',

    ));
  }
}


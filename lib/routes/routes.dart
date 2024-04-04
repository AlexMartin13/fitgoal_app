import 'package:fitgoal_app/screens/screens.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginScreen(),
    'home': (BuildContext context) => BottomNavigation(),
    'register': (BuildContext context) => SignUpScreen(),
    'recover': (BuildContext context) => ForgotPassword(),
    'exercises': (BuildContext context) => ExercisesScreen(),
  };
}
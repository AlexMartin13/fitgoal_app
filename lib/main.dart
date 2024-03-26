import 'package:fitgoal_app/routes/routes.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: getApplicationRoutes(),
    debugShowCheckedModeBanner: false,
  ));
}


import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reducedAppBar(context),
      body: Container(
        color: const Color.fromRGBO(1, 49, 45, 1)
      ),
    );
  }
}
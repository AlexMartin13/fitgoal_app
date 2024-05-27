import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reducedAppBar(context, 'home'),
    );
  }
}
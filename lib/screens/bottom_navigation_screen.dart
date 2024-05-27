import 'package:flutter/material.dart';

import 'screens.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ExerciseMenu(),
    CoachMenu(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(114, 191, 1, 1),
        toolbarHeight: 120,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Transform.scale(
                scale: 5,
                child: Image(
                  image: AssetImage('assets/png_icons/logo.png'),
                  height: 25,
                ),
              ),
            )
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Color.fromRGBO(114, 191, 1, 1),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: [
          _bottomItem(0),
          _bottomItem(1),
        ],
      ),
    );
  }

  BottomNavigationBarItem _bottomItem(int index) {
    return BottomNavigationBarItem(
      icon: Transform.scale(
        scale: 1,
        child: _selectedIndex == 0
            ? index == 0
                ? Image.asset(
                    "assets/png_icons/exercise_icon_activated.png",
                    width: 40,
                    height: 40,
                  )
                : Image.asset(
                    "assets/png_icons/team_icon.png",
                    width: 40,
                    height: 40,
                  )
            : index == 0
                ? Image.asset(
                    "assets/png_icons/exercise_icon.png",
                    width: 40,
                    height: 40,
                  )
                : Image.asset(
                    "assets/png_icons/team_icon_activated.png",
                    width: 40,
                    height: 40,
                  ),
      ),
      label: "",
    );
  }
}

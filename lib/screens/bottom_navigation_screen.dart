import 'package:fitgoal_app/services/team_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  TeamService? teamService;
  int _teamId = 0;

  final List<Widget> _pages = [
    ExerciseMenu(),
    CoachMenu(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<TeamService>(context, listen: false).getTeamLoggedUser();
    teamService = Provider.of<TeamService>(context, listen: false);
    teamService!.getTeamLoggedUser();
  }

  @override
  Widget build(BuildContext context) {
    _teamId = teamService!.teamId;
    print(_teamId);
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
            if (_teamId == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Vincula tu usuario a un equipo para acceder a estas características')));
              return;
            }
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

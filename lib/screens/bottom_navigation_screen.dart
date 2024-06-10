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
  int _teamId = 0;

  final List<Widget> _pages = [
    ExerciseMenu(),
    CoachMenu(),
  ];

  @override
  void initState() {
    super.initState();
    // Se elimina una llamada duplicada a getTeamLoggedUser()
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TeamService>(context, listen: false).getTeamLoggedUser().then((_) {
        setState(() {
          _teamId = Provider.of<TeamService>(context, listen: false).teamId;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // No es necesario asignar _teamId aquí
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
          if (_teamId == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Vincula tu usuario a un equipo para acceder a estas características')));
            return;
          }
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
        child: _selectedIndex == index
            ? Image.asset(
                index == 0
                    ? "assets/png_icons/exercise_icon_activated.png"
                    : "assets/png_icons/team_icon_activated.png",
                width: 40,
                height: 40,
              )
            : Image.asset(
                index == 0
                    ? "assets/png_icons/exercise_icon.png"
                    : "assets/png_icons/team_icon.png",
                width: 40,
                height: 40,
              ),
      ),
      label: "",
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const BottomNavigation());
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.yellow,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => {
          _selectedIndex = index,
        },
        items: [
          BottomNavigationBarItem(
            icon: Image(image: AssetImage("../assets/png_icons/exercise_icon.png"),),
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage("../assets/png_icons/team_icon.png"),),
          )
        ],
      ),
    );
  }
}

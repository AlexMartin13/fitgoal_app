import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/services/team_service.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TeamService? teamService;

  @override
  void initState() {
    super.initState();
    teamService = Provider.of<TeamService>(context, listen: false);
    teamService!.getTeamLoggedUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reducedAppBarWithoutProfile(context, 'exercices'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(58, 120, 23, 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              title: Text(
                "Cambiar contraseña",
                style: TextStyle(color: Colors.white),
              ),
              leading: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              onTap: () async {
                await Navigator.of(context).pushNamed('changePassword');
              },
            ),
          ),
          SizedBox(height: 20.0),
          teamService!.teamId == 0
              ? Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(58, 120, 23, 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(
                      "Formulario de vinculación con equipo",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.sports_soccer,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        'link',
                      );
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

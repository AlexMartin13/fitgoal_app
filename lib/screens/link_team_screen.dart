import 'package:fitgoal_app/models/models.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/services/team_service.dart';
import 'package:fitgoal_app/ui/button_decoration.dart';
import 'package:flutter/material.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:provider/provider.dart';

class LinkTeamScreen extends StatefulWidget {
  const LinkTeamScreen({Key? key}) : super(key: key);

  @override
  _LinkTeamScreenState createState() => _LinkTeamScreenState();
}

class _LinkTeamScreenState extends State<LinkTeamScreen> {
  Team? selectedTeam;
  String dniValue = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final teamService = Provider.of<TeamService>(context, listen: false);
    teamService.getAllTeams();
  }

  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);
    final teamService = Provider.of<TeamService>(context);

    if (selectedTeam != null && !teamService.teams.contains(selectedTeam)) {
      selectedTeam = null;
    }

    return Scaffold(
      appBar: reducedAppBar(context, 'sessions'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<Team>(
                decoration: InputDecoration(
                  labelText: 'Select Team',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                dropdownColor: const Color.fromRGBO(1, 49, 45, 1),
                value: selectedTeam,
                onChanged: (newValue) {
                  setState(() {
                    selectedTeam = newValue;
                  });
                },
                items: teamService.teams.map((team) {
                  return DropdownMenuItem<Team>(
                    value: team,
                    child: Text(
                      team.name,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'DNI',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    dniValue = value;
                  });
                },
                validator: (value) {
                  final regex = RegExp(r'^(\d{8})([A-Z])$');
                  if (value == null || !regex.hasMatch(value)) {
                    return 'DNI inválido. Debe contener 8 dígitos y una letra mayúscula';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _confirmBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _confirmBtn(BuildContext context) {
    return ButtonDecorations.buttonDecoration(
      textButton: 'Mandar formulario',
      textColor: Colors.white,
      textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
      borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
      buttonColor: Color(0xffEAFDE7),
      buttonHorizontalPadding: 105,
      buttonVerticalPadding: 20,
      textSize: 20,
      function: () {
        if (_formKey.currentState?.validate() ?? false) {
          final teamService = Provider.of<TeamService>(context, listen: false);
          teamService.linkUserTeam(LoginService.id, {
            "userId": LoginService.id,
            "teamId": selectedTeam?.id,
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Equipo asociado')));
          Navigator.pop(context);
        }
      },
    );
  }
}

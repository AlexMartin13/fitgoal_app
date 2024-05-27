import 'package:fitgoal_app/models/logged_user.dart';
import 'package:fitgoal_app/screens/player_create_edit_screen.dart';
import 'package:fitgoal_app/screens/player_info_screen.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/services/player_service.dart';
import 'package:fitgoal_app/services/team_service.dart';
import 'package:fitgoal_app/utils/utils.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayersTableScreen extends StatefulWidget {
  const PlayersTableScreen({Key? key}) : super(key: key);

  @override
  _PlayersTableScreenState createState() => _PlayersTableScreenState();
}

class _PlayersTableScreenState extends State<PlayersTableScreen> {
  TeamService? teamService;
  MemoryImage? image;
  late PlayerService _playerService;

  @override
  void initState() {
    super.initState();
    _playerService = Provider.of<PlayerService>(context, listen: false);
    _loadImage();
  }

  void _loadImage() {
    teamService = Provider.of<TeamService>(context, listen: false);
    teamService!.getTeamLoggedUser().then((_) {
      setState(() {
        image = MemoryImage(utils.dataFromBase64String(teamService!.image));
        _playerService.getPlayerByTeamId(teamService!.teamId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = LoginService.user;
    return Scaffold(
      appBar: reducedAppBar(context, 'home'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              _title(image),
              Consumer<PlayerService>(
                builder: (context, playerService, _) {
                  if (playerService.players.isNotEmpty) {
                    return _buildTable(playerService);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(MemoryImage? photo) {
    if (photo == null) {
      return CircularProgressIndicator();
    } else {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerCreateEditScreen(
                          previousRoute: 'players',
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                Text(
                  "Jugadores",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            FadeInImage(
              placeholder: AssetImage('assets/gif/loading.gif'),
              image: photo,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTable(PlayerService playerService) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: DataTable(
          showCheckboxColumn: false,
          border: const TableBorder(
              verticalInside: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Color.fromRGBO(1, 49, 45, 1))),
          dataRowColor:
              MaterialStateProperty.all(Color.fromRGBO(234, 253, 231, 1)),
          decoration: BoxDecoration(color: Color.fromRGBO(168, 202, 116, 1)),
          columns: const [
            DataColumn(label: Text('Nombre')),
            DataColumn(label: Text('Apellidos')),
            DataColumn(label: Text('Posición')),
          ],
          rows: playerService.players
              .map(
                (e) => DataRow(
                  selected: true,
                  onSelectChanged: (value) => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerInfoScreen(),
                        settings: RouteSettings(
                          arguments: e,
                        ),
                      ),
                    )
                  },
                  cells: [
                    e.name.length >= 10
                        ? DataCell(Text(e.name.substring(0, 10) + "..."))
                        : DataCell(Text(e.name)),
                    e.surname.length >= 10
                        ? DataCell(Text(e.surname.substring(0, 10) + "..."))
                        : DataCell(Text(e.surname)),
                    DataCell(Text(e.position)),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

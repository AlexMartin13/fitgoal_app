import 'package:fitgoal_app/services/team_service.dart';
import 'package:fitgoal_app/services/player_service.dart';
import 'package:fitgoal_app/utils/utils.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerAlignScreen extends StatefulWidget {
  static const routeName = '/football-screen';

  @override
  State<PlayerAlignScreen> createState() => _PlayerAlignScreenState();
}

class _PlayerAlignScreenState extends State<PlayerAlignScreen> {
  List<Offset> playerPositions = [
    Offset(150, 650), // GK
    Offset(0, 500), // LB
    Offset(100, 500), // CB
    Offset(200, 500), // CB
    Offset(300, 500), // RB
    Offset(50, 300), // LM
    Offset(150, 300), // DM
    Offset(250, 300), // RM
    Offset(150, 150), // AM
    Offset(50, 75), // CF
    Offset(250, 75), // CF
  ];

  TeamService? teamService;
  late PlayerService _playerService;
  List playersInFormation = [];
  List playersNotInFormation = [];

  @override
  void initState() {
    super.initState();
    _playerService = Provider.of<PlayerService>(context, listen: false);
    _loadData();
  }

  void _loadData() {
    teamService = Provider.of<TeamService>(context, listen: false);
    teamService!.getTeamLoggedUser().then((_) {
      _playerService.getPlayerByTeamId(teamService!.teamId).then((_) {
        setState(() {
          _initializePlayers();
        });
      });
    });
    _loadPositions();
  }

  void _initializePlayers() {
    playersInFormation = _playerService.players.take(11).toList();
    playersNotInFormation = _playerService.players.skip(11).toList();
  }

  Future<void> _loadPositions() async {
    final prefs = await SharedPreferences.getInstance();
    List<Offset>? loadedPositions = _getPositionsFromPrefs(prefs);
    if (loadedPositions != null) {
      setState(() {
        playerPositions = loadedPositions;
      });
    }
  }

  List<Offset>? _getPositionsFromPrefs(SharedPreferences prefs) {
    List<String>? positions = prefs.getStringList('playerPositions');
    if (positions != null) {
      return positions.map((pos) {
        List<String> parts = pos.split(',');
        return Offset(double.parse(parts[0]), double.parse(parts[1]));
      }).toList();
    }
    return null;
  }

  Future<void> _savePositions() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> positions = playerPositions.map((pos) => '${pos.dx},${pos.dy}').toList();
    await prefs.setStringList('playerPositions', positions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reducedAppBar(context, 'home'),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/png_icons/pitch.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<PlayerService>(
          builder: (context, playerService, _) {
            if (playersInFormation.isNotEmpty) {
              return Stack(
                children: List.generate(
                  playersInFormation.length,
                  (index) => _buildDraggable(index, playersInFormation[index]),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildDraggable(int index, player) {
    return Positioned(
      left: playerPositions[index].dx + 15,
      top: playerPositions[index].dy + 30,
      child: GestureDetector(
        onTap: () => _showPlayerSelectionDialog(index),
        child: Draggable(
          child: _playerWidget(index, player),
          feedback: _playerWidget(index, player),
          childWhenDragging: Container(),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              playerPositions[index] = Offset(
                offset.dx - 15,
                offset.dy - 127.1,
              );
              _savePositions();
            });
          },
        ),
      ),
    );
  }

  Widget _playerWidget(int index, player) {
    MemoryImage? playerImage;
    if (player.photo != null) {
      playerImage = MemoryImage(utils.dataFromBase64String(player.photo));
    }

    return CircleAvatar(
      radius: 40,
      backgroundColor: index == 0 ? Colors.blue : Colors.red,
      backgroundImage: playerImage,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: index == 0 ? Colors.white : Colors.black,
            width: 5,
          ),
        ),
        child: Center(
          child: Text(
            player.number.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  void _showPlayerSelectionDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccionar Jugador'),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: playersNotInFormation.length,
              itemBuilder: (BuildContext context, int playerIndex) {
                var player = playersNotInFormation[playerIndex];
                return ListTile(
                  title: Text('${player.name} ${player.surname}'),
                  onTap: () {
                    setState(() {
                      var selectedPlayer = playersInFormation[index];
                      playersInFormation[index] = playersNotInFormation[playerIndex];
                      playersNotInFormation[playerIndex] = selectedPlayer;
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

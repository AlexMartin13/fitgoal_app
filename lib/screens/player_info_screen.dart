import 'package:animate_do/animate_do.dart';
import 'package:fitgoal_app/models/player.dart';
import 'package:fitgoal_app/services/player_service.dart';
import 'package:fitgoal_app/utils/utils.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class PlayerInfoScreen extends StatefulWidget {
  const PlayerInfoScreen({super.key});

  @override
  State<PlayerInfoScreen> createState() => _PlayerInfoScreenState();
}

class _PlayerInfoScreenState extends State<PlayerInfoScreen>
    with TickerProviderStateMixin {
  String name = '';
  String surname = '';
  String position = '';
  PlayerService? playerService;

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat(reverse: true);

  late final Animation<double> animation = Tween<double>(begin: 1, end: 1.2)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDeleteConfirmationDialog(Player player) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Estás seguro de que deseas eliminar a este jugador?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                playerService?.deletePlayer(player.id);
                Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, 'players');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Player player = ModalRoute.of(context)?.settings.arguments as Player;
    playerService = PlayerService();
    return Scaffold(
      appBar: reducedAppBar(context, 'players'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ScaleTransition(
              scale: animation,
              child: FadeInImage(
                placeholder: AssetImage('assets/gif/loading.gif'),
                image: MemoryImage(utils.dataFromBase64String(player.photo)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      '${player.name} ${player.surname}',
                      style: const TextStyle(
                        fontSize: 42,
                        height: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        FadeInRight(
                          duration: const Duration(milliseconds: 750),
                          delay: const Duration(milliseconds: 100),
                          child: Container(
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                player.position,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        FadeInRight(
                          duration: const Duration(milliseconds: 750),
                          delay: const Duration(milliseconds: 100),
                          child: Container(
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'playerCreation',
                                        arguments: player);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(player);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

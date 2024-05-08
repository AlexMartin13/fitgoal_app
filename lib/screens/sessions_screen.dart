import 'package:fitgoal_app/models/session.dart';
import 'package:fitgoal_app/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  TextEditingController _sessionNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<SessionService>(context, listen: false).getSessions();
  }

  @override
  void dispose() {
    _sessionNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionService = Provider.of<SessionService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(114, 191, 1, 1),
        leading: GestureDetector(
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: ImageIcon(
              AssetImage('assets/png_icons/back_arrow.png'),
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, size: 30, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Añadir Sesión'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        TextField(
                          controller: _sessionNameController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre de la Sesión',
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_sessionNameController.text.isNotEmpty) {
                          sessionService.createSession({
                            'name': _sessionNameController.text,
                          });
                          Navigator.pop(context);
                          _sessionNameController.clear();
                          sessionService.getSessions().then((_) => setState(() => {
                            sessionService.getSessions() //hacer lo de exercice session screen
                          }));
                        }
                      },
                      child: const Text('Añadir'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: ListView.builder(
        itemCount: sessionService.sessions.length,
        itemBuilder: (context, index) {
          final session = sessionService.sessions[index];
          return _buildSessionItem(session);
        },
      ),
    );
  }

  Widget _buildSessionItem(Session session) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, 'session', arguments: session);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/gif/loading.gif',
                image: "https://www.eliteguias.com/img/juegos/dark-souls-iii/gran-hacha-de-caballero-negro.jpg",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

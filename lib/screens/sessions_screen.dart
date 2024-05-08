import 'dart:typed_data';

import 'package:fitgoal_app/models/session.dart';
import 'package:fitgoal_app/services/session_service.dart';
import 'package:fitgoal_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  TextEditingController _sessionNameController = TextEditingController();
  SessionService? sessionService;

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
    sessionService = Provider.of<SessionService>(context);
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
                          maxLength: 20,
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
                          sessionService?.createSession({
                            'name': _sessionNameController.text,
                          });
                          Navigator.pop(context);
                          _sessionNameController.clear();
                          sessionService
                              ?.getSessions()
                              .then((_) => setState(() {
                                    sessionService?.getSessions();
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
        itemCount: sessionService?.sessions.length,
        itemBuilder: (context, index) {
          final session = sessionService?.sessions[index];
          return _buildSessionItem(session!);
        },
      ),
    );
  }

  Widget _buildSessionItem(Session session) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, 'session', arguments: session);
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
            child: FadeInImage(
              placeholder: AssetImage('assets/gif/loading.gif'),
              image: session.exercices != null &&
                  session.exercices!.isNotEmpty
                  ? MemoryImage(utils.dataFromBase64String(
                  session.exercices![0].image)) as ImageProvider<Object>
                  : AssetImage('assets/png_icons/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alineación hacia la derecha
                  children: [
                    Expanded(
                      child: Text(
                        session.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_horiz, color: Colors.white),
                      onSelected: (value) =>
                          handlePopupMenuSelected(value, session),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'remove',
                          child: Text('Eliminar sesión'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


  void handlePopupMenuSelected(String value, Session session) {
    switch (value) {
      case 'remove':
        showDialogToDeleteSession(session);
        break;
    }
  }

  void showDialogToDeleteSession(Session session) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Eliminar la sesión"),
          content: Text("¿Estás seguro de que deseas eliminar esta sesión?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                sessionService?.deleteSession(session.id);
                sessionService?.getSessions().then((_) => setState(() {
                      sessionService?.getSessions();
                    }));
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }
}

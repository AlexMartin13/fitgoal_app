import 'package:fitgoal_app/models/session.dart';
import 'package:fitgoal_app/services/session_service.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
    @override
  void initState() {
    super.initState();
    Provider.of<SessionService>(context, listen: false).getSessions();
  }
  @override
  Widget build(BuildContext context) {
    final sessionService = Provider.of<SessionService>(context);
    return Scaffold(
      appBar: reducedAppBar(context),
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
        print("\n\n\nSession Id = ${session.id} \n\n\n");
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          session.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
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

}
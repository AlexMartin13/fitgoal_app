import 'package:fitgoal_app/services/exercice_service.dart';
import 'package:fitgoal_app/utils/utils.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class SessionExerciceScreen extends StatefulWidget {
  const SessionExerciceScreen({Key? key}) : super(key: key);

  @override
  State<SessionExerciceScreen> createState() => _SessionExerciceScreenState();
}

class _SessionExerciceScreenState extends State<SessionExerciceScreen> {
  ExerciceService? exerciceService;
  List<Exercice> exercices = [];
  Session? session;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (ModalRoute.of(context)!.settings.arguments is Session) {
        session = ModalRoute.of(context)!.settings.arguments as Session;
        exerciceService = Provider.of<ExerciceService>(context, listen: false);
        exerciceService!.getExercicesFromSession(session!.id).then((_) {
          setState(() {
            exercices = exerciceService!.exercicesInSession;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reducedAppBar(context, 'sessions'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: ListView.builder(
        itemCount: exercices.length,
        itemBuilder: (context, index) {
          final exercice = exercices[index];
          return _buildExerciceItem(exercice);
        },
      ),
    );
  }

  Widget _buildExerciceItem(Exercice exercice) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'exercice', arguments: exercice);
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
                image: MemoryImage(utils.dataFromBase64String(exercice.image)),
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
                          exercice.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_horiz, color: Colors.white),
                        onSelected: (value) =>
                            handlePopupMenuSelected(value, exercice),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'remove',
                            child: Text('Eliminar de la sesión'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 35,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _buildTagWidgets(exercice.tags!),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

void handlePopupMenuSelected(String value, Exercice exercice) {
  switch (value) {
    case 'remove':
      showDialogToDeleteExerciceInSession(exercice);
      break;
  }
}

void showDialogToDeleteExerciceInSession(Exercice exercice) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Eliminar ejercicio de la sesión"),
        content: Text(
            "¿Estás seguro de que deseas eliminar este ejercicio de la sesión?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              exerciceService?.removeExerciceFromSession(exercice, session!);
              setState(() {
                exercices.remove(exercice); // Elimina el ejercicio de la lista local
              });
              Navigator.of(context).pop(); // Cierra el diálogo
            },
            child: const Text("Eliminar"),
          ),
        ],
      );
    },
  );
}


  List<Widget> _buildTagWidgets(List<Tag> tags) {
    return tags.map((Tag tag) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            color: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              tag.name,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

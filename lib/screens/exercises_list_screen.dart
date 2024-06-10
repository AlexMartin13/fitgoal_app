import 'package:fitgoal_app/services/exercice_service.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/services/session_service.dart';
import 'package:fitgoal_app/utils/utils.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({Key? key}) : super(key: key);
  

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  Session? selectedSession;
  String data = 'Selecciona una sesión';
  ExerciceService exerciceService = ExerciceService();
  @override
  void initState() {
    super.initState();
    Provider.of<ExerciceService>(context, listen: false).getExercices();
    Provider.of<SessionService>(context, listen: false).getSessions();
  }

  @override
  Widget build(BuildContext context) {
    exerciceService = Provider.of<ExerciceService>(context);
    return Scaffold(
      appBar: reducedAppBar(context, 'home'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'add_exercice');
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: ListView.builder(
        itemCount: exerciceService.exercices.length,
        itemBuilder: (context, index) {
          final exercice = exerciceService.exercices[index];
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
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_horiz, color: Colors.white),
                        onSelected: (value) => handlePopupMenuSelected(value, exercice),
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem<String>(
                            value: 'add_to_list',
                            child: Text('Añadir a lista'),
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
      case 'add_to_list':
        showDialogToAddSession(exercice);
        break;
      case 'edit':
        break;
    }
  }

void showDialogToAddSession(Exercice exercice) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Selecciona una sesión"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<Session>(
                  isExpanded: true,
                  value: selectedSession,
                  onChanged: (Session? newValue) {
                    setState(() {
                      selectedSession = newValue;
                    });
                  },
                  items: Provider.of<SessionService>(context, listen: false)
                      .sessions
                      .map<DropdownMenuItem<Session>>((Session session) {
                    return DropdownMenuItem<Session>(
                      value: session,
                      child: Text(session.name),
                    );
                  }).toList(),
                ),
                if (selectedSession != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Sesión: ${selectedSession!.name}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  exerciceService.addExerciceIntoSession(exercice, selectedSession!);
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    },
  );
}


  List<Widget> _buildTagWidgets(List<Tag> tags) {
    return tags.map((tag) {
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

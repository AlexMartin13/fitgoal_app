import 'package:fitgoal_app/services/exercice_service.dart';
import 'package:fitgoal_app/services/login_service.dart';
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
  @override
  void initState() {
    super.initState();
    Provider.of<ExerciceService>(context, listen: false).getExercices();
  }

  @override
  Widget build(BuildContext context) {
    final exerciceService = Provider.of<ExerciceService>(context);
    return Scaffold(
      appBar: reducedAppBar(context),
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
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/gif/loading.gif',
                image: exercice.image,
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
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Añadir a lista',
                            child: Text('Añadir a lista'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Editar',
                            child: Text('Editar'),
                          ),
                        ],
                        onSelected: (String value) {
                          // Handle menu item selection here
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 35,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _buildTagWidgets(exercice.tags),
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

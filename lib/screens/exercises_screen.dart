import 'package:fitgoal_app/services/exercice_service.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/services/tag_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
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
        // TODO: Handle onTap
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        height: 143,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
        ),
        child: Row(
          children: [
            FadeInImage.assetNetwork(
              placeholder: 'assets/gif/loading.gif',
              image: exercice.image,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 20),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 160,
                        child: Text(
                          exercice.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Container(
                          width: 40,
                          child: PopupMenuButton<String>(
                            icon: Icon(Icons.more_horiz),
                            iconColor: Colors.white,
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'Añadir a lista',
                                child: Text('Añadir a lista'),
                              ),
                              PopupMenuItem<String>(
                                value: 'Editar',
                                child: Text('Editar'),
                              ),
                            ],
                            onSelected: (String value) {
                              // Aquí puedes manejar la selección de la opción del menú
                              print(LoginService.user);
                            },
                          ))
                      /*IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_horiz),
                          color: Colors.white,
                        ), */
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 200,
                      height: 60,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [_buildTagScroll(exercice.tags)],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagScroll(List<Tag> tags) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: tags.map((tag) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              color: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                tag.name,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

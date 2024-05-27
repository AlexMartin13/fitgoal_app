import 'package:fitgoal_app/models/models.dart';
import 'package:fitgoal_app/utils/utils.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ExerciceInfo extends StatefulWidget {
  final bool? isFromSession;
  const ExerciceInfo({super.key, this.isFromSession});

  @override
  _ExerciceInfo createState() => _ExerciceInfo();
}

class _ExerciceInfo extends State<ExerciceInfo> {
  String _name = '';
  String _description = '';
  String _image = '';
  String _video = '';

  @override
  Widget build(BuildContext context) {
    Exercice exercice = ModalRoute.of(context)?.settings.arguments as Exercice;
    setState(() {
      _name = exercice.name;
      _description = exercice.description;
      _image = exercice.image;
      _video = '';
    });
    return Scaffold(
      appBar: reducedAppBar(context, 'exercices'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            _imageLocation(),
            const SizedBox(height: 20),
            _exerciceName(context),
            const SizedBox(height: 20),
            _descriptionBox(context)
          ],
        ),
      ),
    );
  }

  Widget _imageLocation() {
    return Container(width: 300, height: 300, child: _carrousel());
  }

  Widget _exerciceName(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *
          0.8, // Ajustar el ancho según sea necesario
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          _name,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _descriptionBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          _description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _carrousel() {
    return CarouselSlider.builder(
        itemCount: 2,
        itemBuilder: (ctx, index, realIdx) {
          return FadeInImage(
            placeholder: AssetImage('assets/gif/loading.gif'),
            image: MemoryImage(utils.dataFromBase64String(_image)),
            fit: BoxFit.cover,
          );
        },
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          aspectRatio: 1.5,
        ));
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:fitgoal_app/screens/exercises_list_screen.dart';
import 'package:fitgoal_app/services/exercice_service.dart';
import 'package:fitgoal_app/ui/button_decoration.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddExerciceScreen extends StatefulWidget {
  const AddExerciceScreen({Key? key}) : super(key: key);

  @override
  _AddExerciceScreenState createState() => _AddExerciceScreenState();
}

class _AddExerciceScreenState extends State<AddExerciceScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String _nameValue = '';
  String _descriptionValue = '';
  String? _imageBase64;
  ExerciceService? exerciceService;
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    exerciceService = Provider.of<ExerciceService>(context);
    return Scaffold(
      appBar: reducedAppBar(context, 'exercices'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _imageContainer(),
              const SizedBox(height: 20),
              _exerciceNameField(),
              const SizedBox(height: 20),
              _descriptionField(),
              const SizedBox(height: 20),
              _buttonAddExercice(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageContainer() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(width: 3),
            borderRadius: BorderRadius.circular(25),
          ),
          child: _imageFile != null
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _nameValue = '';
                      _descriptionValue = '';
                      _imageBase64 = null;
                      _imageFile = null;
                    });
                  },
                  child: Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  ),
                )
              : _imageBase64 != null
                  ? Image.memory(
                      base64Decode(_imageBase64!),
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.image,
                      size: 100,
                      color: Colors.white,
                    ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            icon: const Icon(Icons.camera),
            onPressed: () {
              _getImage(source: ImageSource.camera);
            },
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: () {
              _getImage(source: ImageSource.gallery);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _getImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      String base64Image = getBase64FormateFile(pickedFile.path);
      setState(() {
        _nameValue = '';
        _descriptionValue = '';
        _imageBase64 = base64Image;
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Widget _exerciceNameField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: _nameController,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Nombre del ejercicio',
          hintStyle: TextStyle(
            fontSize: 20,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _nameValue = value;
          });
        },
      ),
    );
  }

  Widget _descriptionField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: _descriptionController,
        maxLines: null,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Descripción del ejercicio',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _descriptionValue = value;
          });
        },
      ),
    );
  }

  Widget _buttonAddExercice() {
    return ButtonDecorations.buttonDecoration(
      textButton: 'Añadir Ejercicio',
      textColor: Colors.white,
      textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
      borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
      buttonColor: Color(0xffEAFDE7),
      buttonHorizontalPadding: 40,
      buttonVerticalPadding: 20,
      textSize: 14,
      function: () {
        var data = {
          'name': _nameValue,
          'description': _descriptionValue,
          'image': _imageBase64,
        };
        exerciceService!.createExercice(data);
        Navigator.popUntil(context, ModalRoute.withName('exercices'));
      },
    );
  }

  static String getBase64FormateFile(String path) {
    File file = File(path);
    List<int> fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    return fileInBase64;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

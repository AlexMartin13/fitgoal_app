import 'dart:convert';
import 'package:fitgoal_app/models/player.dart';
import 'package:fitgoal_app/models/positions.dart';
import 'package:fitgoal_app/services/login_service.dart';
import 'package:fitgoal_app/services/player_service.dart';
import 'package:fitgoal_app/services/team_service.dart';
import 'package:fitgoal_app/ui/button_decoration.dart';
import 'package:fitgoal_app/utils/utils.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class PlayerCreateEditScreen extends StatefulWidget {
  final Player? player;
  final String? previousRoute;

  const PlayerCreateEditScreen({Key? key, this.player, this.previousRoute})
      : super(key: key);

  @override
  State<PlayerCreateEditScreen> createState() => _PlayerCreateEditScreenState();
}

class _PlayerCreateEditScreenState extends State<PlayerCreateEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _numberController; // New controller for number
  String? _selectedPosition;
  File? _image;
  Player? _player;
  PlayerService playerService = PlayerService();
  int? teamId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _numberController = TextEditingController(); // Initialize the new controller
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_player == null) {
      _player = ModalRoute.of(context)?.settings.arguments as Player?;
      if (_player != null) {
        _nameController.text = _player!.name;
        _surnameController.text = _player!.surname;
        _numberController.text = _player!.number.toString(); // Set the initial value for number
        _selectedPosition = _player!.position;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _numberController.dispose(); // Dispose of the new controller
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
      if (_player != null) {
        _player = _player!.copyWith(photo: '');
      }
    });
  }

  void _showIncompleteFieldsAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Campos incompletos'),
          content: Text('Por favor, complete todos los campos antes de continuar.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_player == null) {
      teamId = utils.teamId;
    }
    return Scaffold(
      appBar: reducedAppBar(context, widget.previousRoute ?? 'players'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NameField(controller: _nameController),
              SizedBox(height: 20),
              SurnameField(controller: _surnameController),
              SizedBox(height: 20),
              NumberField(controller: _numberController), // Add the new field here
              SizedBox(height: 20),
              PositionDropdown(
                selectedPosition: _selectedPosition,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPosition = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              ImageSelector(
                image: _image,
                playerPhoto: _player?.photo,
                onPickImage: _pickImage,
                onRemoveImage: _removeImage,
              ),
              SizedBox(
                height: 20,
              ),
              _buttonAccept()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonAccept() {
    return Center(
      child: ButtonDecorations.buttonDecoration(
        textButton: _player == null ? 'Añadir Jugador' : 'Editar jugador',
        textColor: Colors.white,
        textStrokeColor: Color.fromRGBO(1, 49, 45, 1),
        borderButtonColor: Color.fromRGBO(114, 191, 1, 1),
        buttonColor: Color(0xffEAFDE7),
        buttonHorizontalPadding: 40,
        buttonVerticalPadding: 20,
        textSize: 14,
        function: () async {
          String name = _nameController.text;
          String surname = _surnameController.text;
          String number = _numberController.text; // Get the number value
          String position = _selectedPosition ?? '';
          String photo = _image != null
              ? await getBase64FormateFile(_image!)
              : _player?.photo ?? '';

          if (name.isEmpty || surname.isEmpty || number.isEmpty || position.isEmpty || photo.isEmpty) {
            _showIncompleteFieldsAlert();
            return;
          }

          var data = {
            'Name': name,
            'Surname': surname,
            'number': int.parse(number), // Add the number to the data
            'position': position,
            'photo': photo,
            'teamId': teamId,
          };

          if (_player == null) {
            playerService.addPlayer(data);
          } else {
            playerService.updatePlayer(_player!.id, data);
          }
                Navigator.pushNamedAndRemoveUntil(
                context, 'players', (route) => false);
        },
      ),
    );
  }

  Future<String> getBase64FormateFile(File file) async {
    List<int> fileInByte = await file.readAsBytes();
    String fileInBase64 = base64Encode(fileInByte);
    return fileInBase64;
  }
}

// Name Field Widget
class NameField extends StatelessWidget {
  final TextEditingController controller;

  const NameField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nombre',
          style: TextStyle(color: Colors.white),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'John',
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class SurnameField extends StatelessWidget {
  final TextEditingController controller;

  const SurnameField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Apellidos',
          style: TextStyle(color: Colors.white),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Doe',
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class NumberField extends StatelessWidget {
  final TextEditingController controller;

  const NumberField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dorsal',
          style: TextStyle(color: Colors.white),
        ),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number, // Set keyboard type to number
          decoration: InputDecoration(
            hintText: '10',
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class PositionDropdown extends StatelessWidget {
  final String? selectedPosition;
  final ValueChanged<String?>? onChanged;

  const PositionDropdown({this.selectedPosition, this.onChanged});

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> items = [];
    for (Position position in Position.values) {
      items.add(DropdownMenuItem(
        value: position.toString().split('.').last,
        child: Text(
          position.toString().split('.').last,
          style: TextStyle(color: Colors.black),
        ),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Posición',
          style: TextStyle(color: Colors.white),
        ),
        DropdownButton<String>(
          dropdownColor: Colors.white,
          value: selectedPosition,
          onChanged: onChanged,
          items: getDropdownItems(),
          hint: Text(
            'Selecciona posición',
            style: TextStyle(color: Colors.white),
          ),
          isExpanded: true,
        ),
      ],
    );
  }
}

class ImageSelector extends StatelessWidget {
  final File? image;
  final String? playerPhoto;
  final Function(ImageSource) onPickImage;
  final VoidCallback onRemoveImage;

  const ImageSelector({
    this.image,
    this.playerPhoto,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRemoveImage,
      child: Container(
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(10),
        ),
        child: image != null
            ? Image.file(
                image!,
                fit: BoxFit.cover,
              )
            : (playerPhoto != null && playerPhoto!.isNotEmpty
                ? Image.memory(
                    utils.dataFromBase64String(playerPhoto!),
                    fit: BoxFit.cover,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.photo_library, color: Colors.white),
                        onPressed: () => onPickImage(ImageSource.gallery),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () => onPickImage(ImageSource.camera),
                      ),
                    ],
                  )),
      ),
    );
  }
}

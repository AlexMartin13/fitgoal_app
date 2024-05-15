import 'package:fitgoal_app/models/player.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class PlayerCreateEditScreen extends StatefulWidget {
  final Player? player;

  const PlayerCreateEditScreen({Key? key, this.player}) : super(key: key);

  @override
  State<PlayerCreateEditScreen> createState() => _PlayerCreateEditScreenState();
}

class _PlayerCreateEditScreenState extends State<PlayerCreateEditScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  String? _selectedPosition;

  @override
  void initState() {
    super.initState();
    if (widget.player != null) {
      _nameController.text = widget.player!.name;
      _surnameController.text = widget.player!.surname;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reducedAppBar(context, 'player'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name'),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter name',
              ),
            ),
            SizedBox(height: 20),
            Text('Surname'),
            TextFormField(
              controller: _surnameController,
              decoration: InputDecoration(
                hintText: 'Enter surname',
              ),
            ),
            SizedBox(height: 20),
            Text('Position'),
            DropdownButton<String>(
              value: _selectedPosition,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPosition = newValue;
                });
              },
              items: [],
            ),
          ],
        ),
      ),
    );
  }
}

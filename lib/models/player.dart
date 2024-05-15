import 'dart:convert';

import 'package:fitgoal_app/models/positions.dart';

class Player {
  int id;
  String name;
  String surname;
  String photo;
  String position;


  Player({
    required this.id,
    required this.name,
    required this.surname,
    required this.photo,
    required this.position,
  });

  Player.empty()
      : id = 0,
        name = '',
        surname = '',
        photo = '',
        position = '';

  factory Player.fromRawJson(String str) =>
      Player.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        photo: json["photo"],
        position: json["positions"][0]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "photo": photo,
        "positions": position.toString()
      };

  @override
  String toString() {
    return 'PlayerSession {'
        'id: $id, '
        'name: $name, '
        'surname: $surname,'
        'photo: $photo, '
        'position: $position';
  }

  static List<Player> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Player.fromJson(json)).toList();
  }
}

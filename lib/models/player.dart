import 'dart:convert';

import 'package:fitgoal_app/models/positions.dart';

class Player {
  int id;
  String name;
  String surname;
  String photo;
  String position;
  int teamId;

  Player({
    required this.id,
    required this.name,
    required this.surname,
    required this.photo,
    required this.position,
    required this.teamId,
  });

  Player.empty()
      : id = 0,
        name = '',
        surname = '',
        photo = '',
        position = '',
        teamId = 0;

  Player copyWith({
    String? name,
    String? surname,
    String? position,
    String? photo,
    int? teamId
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      position: position ?? this.position,
      photo: photo ?? this.photo,
      teamId: teamId ?? 0
    );
  }

  factory Player.fromRawJson(String str) => Player.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Player.fromJson(Map<String, dynamic> json) => Player(
      id: json["id"],
      name: json["name"],
      surname: json["surname"],
      photo: json["photo"],
      position: json["positions"],
      teamId: json["team"]["id"] );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "photo": photo,
        "positions": position.toString(),
        "teamId": teamId,
      };

  @override
  String toString() {
    return 'PlayerSession {'
        'id: $id, '
        'name: $name, '
        'surname: $surname,'
        'photo: $photo, '
        'positions: $position,'
        'teamId: $teamId';
  }

  static List<Player> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Player.fromJson(json)).toList();
  }
}

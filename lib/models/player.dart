import 'dart:convert';

class Player {
  int id;
  String name;
  String photo;
  int yellowCards;
  int redCards;
  int minutes;

  Player({
    required this.id,
    required this.name,
    required this.photo,
    required this.yellowCards,
    required this.redCards,
    required this.minutes,
  });

  Player.empty()
      : id = 0,
        name = '',
        photo = '',
        yellowCards = 0,
        redCards = 0,
        minutes = 0;

  factory Player.fromRawJson(String str) =>
      Player.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        yellowCards: json["yellowCards"],
        redCards: json["redCards"],
        minutes: json["minutes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "yellowCards": yellowCards,
        "redCards": redCards,
        "minutes": minutes,
      };

  @override
  String toString() {
    return 'PlayerSession {'
        'id: $id, '
        'name: $name, '
        'photo: $photo, '
        'yellowCards: $yellowCards, '
        'redCards: $redCards, '
        'minutes: $minutes';
  }

  static List<Player> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Player.fromJson(json)).toList();
  }
}

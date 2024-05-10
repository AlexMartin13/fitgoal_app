import 'package:fitgoal_app/models/player.dart';
import 'package:flutter/foundation.dart';

class Team {
  int id;
  String name;
  String province;
  String city;
  String crest;
  List<Player>? players;

  Team({
    required this.id,
    required this.name,
    required this.province,
    required this.city,
    required this.crest,
    this.players,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json['id'],
        name: json['name'],
        province: json['province'],
        city: json['city'],
        crest: json['crest'],
        players: (json['players'] as List<dynamic>?)
            ?.map((player) => Player.fromJson(player))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'province': province,
        'city': city,
        'crest': crest,
      };
}


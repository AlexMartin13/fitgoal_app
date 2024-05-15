import 'dart:convert';

import 'package:fitgoal_app/models/models.dart';

class Team{
  int id;
  String name;
  String crest;

  Team({
    required this.id,
    required this.name,
    required this.crest
  });

  Team.empty()
      : id = 0,
        name = '',
        crest = '';


  factory Team.fromRawJson(String str) => Team.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        crest: json["crest"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "crest": crest
      };

  @override
  String toString() {
    return 'Team {'
        'id: $id, '
        'name: $name, '
        'crest: $crest,';
  }

  static List<Team> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Team.fromJson(json)).toList();
  }

}
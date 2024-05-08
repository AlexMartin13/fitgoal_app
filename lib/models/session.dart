import 'dart:convert';

import 'package:fitgoal_app/models/models.dart';

class Session{
  int id;
  String name;
  String url;
  List<User>? allowedUsers;

  Session({
    required this.id,
    required this.name,
    required this.url,
    this.allowedUsers,
  });

  Session.empty()
      : id = 0,
        name = '',
        url = '',
        allowedUsers = [];

  factory Session.fromRawJson(String str) =>
      Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        allowedUsers: List<User>.from(json["allowedUsers"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  @override
  String toString() {
    return 'Exercise {'
        'id: $id, '
        'name: $name, '
        'url: $url, '
        'allowedUsers: $allowedUsers';
  }

  static List<Session> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Session.fromJson(json)).toList();
  }

}
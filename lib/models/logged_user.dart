import 'dart:convert';

import 'package:fitgoal_app/models/team.dart';

class LoggedUser {
  String token;
  String type;
  int id;
  String name;
  String surname;
  String email;
  String password;
  Team? team;
  List<String> roles;

  LoggedUser({
    required this.token,
    required this.type,
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    team,
    required this.roles
  });

  LoggedUser.empty()
      : token = '',
        type = '',
        id = 0,
        name = '',
        surname = '',
        email = '',
        password = '',
        roles = <String>[];

  factory LoggedUser.fromRawJson(String str) =>
      LoggedUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoggedUser.fromJson(Map<String, dynamic> json) => LoggedUser(
        token: json["token"],
        type: json["type"],
        id: json["id"],
        name: json["name"],
        surname: json["surnames"],
        email: json["email"],
        password: json["password"],
        team: json["team"],
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "type": type,
        "id": id,
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
        "team": team,
        "roles": List<dynamic>.from(roles.map((x) => x)),
      };

  @override
  String toString() {
    return 'LoggedCliente {'
        'token: $token, '
        'type: $type, '
        'id: $id, '
        'name: $name, '
        'surname: $surname, '
        'email: $email, '
        'password: $password, '
        'team: $team, '
        'roles: $roles}';
  }
}
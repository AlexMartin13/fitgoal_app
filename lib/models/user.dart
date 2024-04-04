import 'dart:convert';

class User {
  int id;
  String name;
  String surname;
  String email;
  String password;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });


  User.empty()
      : id = 0,
        name = '',
        surname = '',
        email = '',
        password = '';

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
      };

  @override
  String toString() {
    return 'User {'
        'id: $id, '
        'name: $name, '
        'surname: $surname, '
        'email: $email, '
        'password: $password}';
  }
}

import 'dart:convert';

import 'models.dart';

class Exercice {
  int id;
  String name;
  String description;
  String? video;
  String image;
  List<Tag> tags;

  Exercice({
    required this.id,
    required this.name,
    required this.description,
    this.video,
    required this.image,
    required this.tags,
  });
  Exercice.empty()
      : id = 0,
        name = '',
        description = '',
        video = '',
        image = '',
        tags = [];

  factory Exercice.fromRawJson(String str) =>
      Exercice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Exercice.fromJson(Map<String, dynamic> json) => Exercice(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        video: json["video"],
        image: json["image"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "video": video,
        "image": image,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Exercise {'
        'id: $id, '
        'name: $name, '
        'description: $description, '
        'video: $video, '
        'image: $image, '
        'tags: $tags}';
  }

  static List<Exercice> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Exercice.fromJson(json)).toList();
  }
}

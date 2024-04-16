class Tag {
  int id;
  String name;

  Tag({
    required this.id,
    required this.name,
  });

  Tag.empty()
    : id = 0,
      name = '';

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() {
    return 'Tag {'
        'id: $id, '
        'name: $name}';
  }

    static List<Tag> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Tag.fromJson(json)).toList();
  }
}

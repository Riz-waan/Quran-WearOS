class Favorite {
  int key;
  String name;

  Favorite({
    this.key,
    this.name,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        key: json['key'],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
      };

  @override
  String toString() {
    return """
    id: $key,
    name: $name
    ----------------------------------
    """;
  }
}

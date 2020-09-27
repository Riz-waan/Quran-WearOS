class Surah {
  int key;
  String name;

  Surah({
    this.key,
    this.name,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
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

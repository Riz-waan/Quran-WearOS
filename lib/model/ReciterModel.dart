class Reciter {
  int key;
  String name;

  Reciter({
    this.key,
    this.name,
  });

  factory Reciter.fromJson(Map<String, dynamic> json) => Reciter(
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

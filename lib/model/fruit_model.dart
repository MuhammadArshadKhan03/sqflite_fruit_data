class Fruit {
  final String name;
  final int? id;

  Fruit({required this.name, this.id});

  factory Fruit.fromMap(Map<String, dynamic> json) => Fruit(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "id": id,
    };
  }
}

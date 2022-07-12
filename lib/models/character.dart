import 'package:flutter/foundation.dart';

class Character {
  String? id;
  String? name;
  String? title;
  String? image;
  String? description;
  List? tags;
  Stats? stats;

  Character({
    this.id,
    this.name,
    this.title,
    this.image,
    this.description,
    this.tags,
    this.stats,
  });

  factory Character.formJson(Map<String, dynamic> json) {
    return Character(
      id: json["id"],
      name: json["name"],
      title: json["title"],
      image: json["icon"],
      description: json["description"],
      tags: json["tags"],
      stats: Stats.fromJson(json["stats"]),
    );
  }

  @override
  String toString() {
    return 'Character(id: $id, name: $name, title: $title, image: $image, description: $description)';
  }
}

class Stats {
  double? hp;
  double? mp;
  double? movespeed;
  double? armor;
  double? attackspeed;
  double? attackdamage;
  double? attackrange;

  Stats({
    this.hp,
    this.mp,
    this.movespeed,
    this.armor,
    this.attackspeed,
    this.attackdamage,
    this.attackrange,
  });

  factory Stats.fromJson(Map<String, dynamic> parseJson) {
    return Stats(
      hp: double.tryParse(parseJson["hp"].toString()),
      mp: double.tryParse(parseJson["mp"].toString()),
      movespeed: double.tryParse(parseJson["movespeed"].toString()),
      armor: double.tryParse(parseJson["armor"].toString()),
      attackspeed: double.tryParse(parseJson["attackspeed"].toString()),
      attackdamage: double.tryParse(parseJson["attackdamage"].toString()),
      attackrange: double.tryParse(parseJson["attackrange"].toString()),
    );
  }
}

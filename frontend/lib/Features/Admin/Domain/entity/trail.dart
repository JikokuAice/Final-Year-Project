import 'dart:convert';

class Trail {
  String name;
  List<String> images;
  String description;
  String trailType;
  double length;
  double? elevation;
  String difficulty;
  String? location;

  Trail(
      {required this.name,
      required this.images,
      required this.description,
      required this.trailType,
      required this.length,
      this.elevation,
      required this.location,
      required this.difficulty});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "images": images,
      "description": description,
      "trailType": trailType,
      "length": length,
      "elevation": elevation ?? 0,
      "difficulty": difficulty,
      "location": location
    };
  }

  factory Trail.fromJson(Map<String, dynamic> json) {
    return Trail(
        name: json['name'],
        images: json['images'].cast<String>(),
        description: json['description'],
        trailType: json['trailType'],
        length: json['length'],
        elevation: json['elevation'],
        difficulty: json['difficulty'],
        location: json['location']);
  }
}

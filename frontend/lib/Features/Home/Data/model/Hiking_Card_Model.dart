class HikingCardModel {
  int id;
  String? name;
  List<dynamic>? images;
  int? length;
  int? rating;
  String? difficulty;

  HikingCardModel(
      {required this.id,
      this.name,
      this.difficulty,
      this.images,
      this.length,
      this.rating});

  factory HikingCardModel.fromJson(Map<String, dynamic> json) {
    return HikingCardModel(
        id: json['id'],
        name: json['name'],
        images: json['images'],
        length: json['length'],
        rating: json['rating'],
        difficulty: json['difficulty']);
  }
}

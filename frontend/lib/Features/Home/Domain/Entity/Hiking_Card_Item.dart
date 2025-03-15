class HikingCardItem {
  int id;
  String? name;
  List<dynamic>? images;
  int? length;
  int? rating;
  String? difficulty;

  HikingCardItem(
      {required this.id,
      this.name,
      this.images,
      this.difficulty,
      this.length,
      this.rating});
}

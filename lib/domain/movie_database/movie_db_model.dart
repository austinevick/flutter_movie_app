class ModelDBModel {
  int? id;
  final String? image;
  final String? title;
  final bool? isFavourite;
  ModelDBModel({
    this.id,
    this.image,
    this.title,
    this.isFavourite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'isFavourite': isFavourite! ? 0 : 1,
    };
  }

  factory ModelDBModel.fromMap(Map<String, dynamic> map) {
    return ModelDBModel(
      id: map['id']?.toInt(),
      image: map['image'],
      title: map['title'],
      isFavourite: map['isFavourite'] == 0,
    );
  }
}

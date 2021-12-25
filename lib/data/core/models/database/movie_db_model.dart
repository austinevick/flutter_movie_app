const String TABLE = 'MovieCollections';
const String DB_NAME = 'movie.db';

const String ID = 'id';
const String TITLE = 'title';
const String IMAGE = 'image';
const String DATE = 'date';
const String ISFAVOURITE = 'isFavourite';

class MovieDBModel {
  int? id;
  final String? title;
  final String? image;
  final DateTime? date;
  final bool isFavourite;
  MovieDBModel({
    this.id,
    this.title,
    this.image,
    this.date,
    this.isFavourite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'date': date!.toIso8601String(),
      'isFavourite': isFavourite ? 1 : 0,
    };
  }

  factory MovieDBModel.fromMap(Map<String, dynamic> map) {
    return MovieDBModel(
      id: map['id']?.toInt(),
      title: map['title'],
      image: map['image'],
      date: DateTime.parse(map['date'] as String),
      isFavourite: map['isFavourite'] == 0,
    );
  }

  @override
  String toString() {
    return 'MovieDBModel(id: $id, title: $title, image: $image, date: $date, isFavourite: $isFavourite)';
  }
}

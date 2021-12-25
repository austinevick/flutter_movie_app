import 'package:hive/hive.dart';

part 'movie_db_model.g.dart';

@HiveType(typeId: 0)
class MovieDBModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final DateTime? date;
  @HiveField(4)
  final bool? isFavourite;
  MovieDBModel({
    this.id,
    this.title,
    this.image,
    this.date,
    this.isFavourite,
  });
}

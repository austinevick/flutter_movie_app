import 'package:flutter_riverpod_movie_app/domain/entities/movie_detail_entity.dart';

class MovieDetailModel extends MovieDetailEntity {
  final List<Genres> genres;
  final String homepage;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final String backdropPath;
  const MovieDetailModel({
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.backdropPath,
  }) : super(
            id: id,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            voteCount: voteCount,
            title: title,
            voteAverage: voteAverage,
            backdropPath: backdropPath);

  Map<String, dynamic> toMap() {
    return {
      'genres': genres.map((x) => x.toMap()).toList(),
      'homepage': homepage,
      'id': id,
      'originalTitle': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'posterPath': posterPath,
      'title': title,
      'video': video,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
      'backdropPath': backdropPath,
    };
  }

  factory MovieDetailModel.fromJson(Map<String, dynamic> map) {
    return MovieDetailModel(
      genres: List<Genres>.from(map['genres']?.map((x) => Genres.fromMap(x))),
      homepage: map['homepage'] ?? '',
      id: map['id']?.toInt() ?? 0,
      originalTitle: map['original_title'] ?? '',
      overview: map['overview'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      posterPath: map['poster_path'] ?? '',
      title: map['title'] ?? '',
      video: map['video'] ?? false,
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      voteCount: map['vote_count']?.toInt() ?? 0,
      backdropPath: map['backdrop_path'] ?? '',
    );
  }
}

class Genres {
  final int id;
  final String name;
  Genres({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Genres.fromMap(Map<String, dynamic> map) {
    return Genres(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }
}

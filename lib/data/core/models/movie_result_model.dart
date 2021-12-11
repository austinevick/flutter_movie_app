import 'movie_model.dart';

class MoviesResultModel {
  late final List<MovieModel>? movies;

  MoviesResultModel({this.movies});

  MoviesResultModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      movies = [];
      json['results'].forEach((v) {
        movies!.add(MovieModel.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (movies != null) {
      data['results'] = movies!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

import 'movie_model.dart';

class MoviesResultModel {
  final List<MovieModel>? movies = [];

  MoviesResultModel.fromJson(Map<String, dynamic> json) {
    json['results'].forEach((v) {
      return movies!.add(MovieModel.fromMap(v));
    });
  }
}

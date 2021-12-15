import 'movie_model.dart';

class MoviesResultModel {
  final List<MovieModel>? movies = [];

  MoviesResultModel.fromJson(Map<String, dynamic> json) {
    json['results'].forEach((v) {
      return movies!.add(MovieModel.fromMap(v));
    });

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};

      if (movies != null) {
        data['results'] = movies!.map((v) => v.toMap()).toList();
      }
      return data;
    }
  }
}

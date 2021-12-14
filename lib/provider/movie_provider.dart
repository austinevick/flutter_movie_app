import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_client.dart';
import 'package:flutter_riverpod_movie_app/data/core/data_source/movie_remote_data_source.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/domain/repositories/movie_repository.dart';
import 'package:http/http.dart';

final movieProvider = ChangeNotifierProvider<MovieProvider>((ref) {
  return MovieProvider();
});

class MovieProvider extends ChangeNotifier {
  List<MovieEntity> trendingMovies = [];
  final int defaultIndex = 0;
  MovieRepository trending = MovieRepository();

  Future<List<MovieEntity>> getTrendingMovies() async {
    Future<List<MovieEntity>> movies = trending.getTrending();
    return movies.then((movies) {
      trendingMovies = movies;
      notifyListeners();
      return movies;
    });
  }
}

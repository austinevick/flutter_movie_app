import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/domain/repositories/movie_repository.dart';

final movieProvider = ChangeNotifierProvider<MovieProvider>((ref) {
  return MovieProvider();
});

class MovieProvider extends ChangeNotifier {
  MovieRepository repository = MovieRepository();
  List<MovieEntity> movies = [];

  Future<List<MovieEntity>> getTrendingMovies() async {
    Future<List<MovieEntity>> movies = repository.getTrending();
    return movies.then((movies) {
      movies = movies;
      notifyListeners();
      return movies;
    });
  }

  Future<List<MovieEntity>> getComingSoonMovies() async {
    Future<List<MovieEntity>> movies = repository.getComingSoon();
    return movies.then((movies) {
      movies = movies;
      notifyListeners();
      return movies;
    });
  }

  Future<List<MovieEntity>> getPlayingNowMovies() async {
    Future<List<MovieEntity>> movies = repository.getPlayingNow();
    return movies.then((movies) {
      movies = movies;
      notifyListeners();
      return movies;
    });
  }

  Future<List<MovieEntity>> getPopularMovies() async {
    Future<List<MovieEntity>> movies = repository.getPopular();
    return movies.then((movies) {
      movies = movies;
      notifyListeners();
      return movies;
    });
  }
}

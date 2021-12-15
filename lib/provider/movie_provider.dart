import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/movie_detail_model.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_detail_entity.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/domain/repositories/movie_repository.dart';

final movieProvider = ChangeNotifierProvider<MovieProvider>((ref) {
  return MovieProvider();
});

class MovieProvider extends ChangeNotifier {
  MovieRepository repository = MovieRepository();
  List<MovieEntity> movies = [];
  MovieDetailEntity movieDetailEntity = const MovieDetailEntity();

  Future<List<MovieEntity>> getTrendingMovies() async {
    Future<List<MovieEntity>> movies = repository.getTrending();
    return movies.then((movies) {
      this.movies = movies;
      notifyListeners();
      return movies;
    });
  }

  Future<List<MovieEntity>> getComingSoonMovies() async {
    Future<List<MovieEntity>> movies = repository.getComingSoon();
    return movies.then((movies) {
      this.movies = movies;
      notifyListeners();
      return movies;
    });
  }

  Future<List<MovieEntity>> getPlayingNowMovies() async {
    Future<List<MovieEntity>> movies = repository.getPlayingNow();
    return movies.then((movies) {
      this.movies = movies;
      notifyListeners();
      return movies;
    });
  }

  Future<List<MovieEntity>> getPopularMovies() async {
    Future<List<MovieEntity>> movies = repository.getPopular();
    return movies.then((movies) {
      this.movies = movies;
      notifyListeners();
      return movies;
    });
  }

  Future<List<MovieEntity>> getTopRatedMovies() async {
    Future<List<MovieEntity>> movies = repository.getTopRated();
    return movies.then((movies) {
      this.movies = movies;
      notifyListeners();
      return movies;
    });
  }

  Future<MovieDetailEntity> getMovieDetail({required int id}) async {
    Future<MovieDetailEntity> movies = repository.getDetail(id: id);
    return movies.then((movies) {
      movieDetailEntity = movies;
      notifyListeners();
      return movies;
    });
  }
}

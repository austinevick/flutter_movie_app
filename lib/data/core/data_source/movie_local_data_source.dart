import 'package:flutter_riverpod_movie_app/data/core/constant.dart';
import 'package:flutter_riverpod_movie_app/domain/movie_database/movie_db_model.dart';
import 'package:hive/hive.dart';

class MovieLocalDataSource {
  Future<void> saveMovie(MovieDBModel movie) async {
    final movieBox = await Hive.openBox(DBNAME);
    print(movieBox.values.first);
    await movieBox.put(movie.id, movie);
  }

  Future<List<MovieDBModel>> getMovies() async {
    final movieBox = await Hive.openBox(DBNAME);
    final movieIds = movieBox.keys;
    List<MovieDBModel> movies = [];
    movieIds.forEach((movieId) {
      movies.add(movieBox.get(movieId));
    });
    return movies;
  }

  Future<void> deleteMovie(int id) async {
    final movieBox = await Hive.openBox(DBNAME);
    await movieBox.delete(id);
    await getMovies();
  }
}
import 'package:flutter_riverpod_movie_app/data/core/models/database/movie_db_model.dart';
import 'package:flutter_riverpod_movie_app/domain/movie_database/movie_db.dart';

class MovieDBProvider {
  MovieDBHelper dbHelper = MovieDBHelper();

  Future<List<MovieDBModel>> getFavouriteMovies() async {
    return await dbHelper.getMovies();
  }

  Future<MovieDBModel> saveFavouriteMovies(MovieDBModel movies) async {
    return await dbHelper.save(movies);
  }

  Future<int> deleteFavouriteMovies(int id) async {
    return await dbHelper.deleteMovie(id);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/constant.dart';
import 'package:flutter_riverpod_movie_app/data/core/data_source/movie_local_data_source.dart';
import 'package:flutter_riverpod_movie_app/domain/movie_database/movie_db_model.dart';
import 'package:hive/hive.dart';

final movieDBProvider = Provider<MovieDBProvider>((ref) => MovieDBProvider());

class MovieDBProvider {
  final localDataSource = MovieLocalDataSource();
  Box movieBox = Hive.box(DBNAME);

  Future<List<MovieDBModel>> getFavouriteMovies() async {
    return await localDataSource.getMovies();
  }

  Future<void> deleteFavouriteMovies(int id) async {
    return await localDataSource.deleteMovie(id);
  }

  Future<void> toggleFavoriteMovie(MovieDBModel movie) async {
    final movieBox = await Hive.openBox(DBNAME);
    if (movieBox.containsKey(movie.id)) {
      await localDataSource.deleteMovie(movie.id!);
    } else {
      await localDataSource.saveMovie(movie);
    }
    await getFavouriteMovies();
  }
}

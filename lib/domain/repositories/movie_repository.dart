import 'dart:io';

import 'package:flutter_riverpod_movie_app/data/core/api_client.dart';
import 'package:flutter_riverpod_movie_app/data/core/data_source/movie_remote_data_source.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/cast_crew_model.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/movie_detail_model.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/movie_trailer_model.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/recommendation_model.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:http/http.dart';

class MovieRepository {
  final ApiClient _client = ApiClient(Client());
  MovieRemoteDataSource get remoteDataSource =>
      MovieRemoteDataSourceImpl(_client);

  Future<List<MovieEntity>> getComingSoon() async {
    try {
      return await remoteDataSource.getComingSoon();
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<MovieEntity>> getPlayingNow() async {
    try {
      return await remoteDataSource.getPlayingNow();
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<MovieEntity>> getPopular() async {
    try {
      return await remoteDataSource.getPopular();
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<MovieEntity>> getTrending() async {
    try {
      return await remoteDataSource.getTrending();
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<MovieEntity>> getUpcomingMovies() async {
    try {
      return await remoteDataSource.getUpcomingMovies();
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<MovieEntity>> getSearchMovies(String searchTerm) async {
    try {
      return await remoteDataSource.getSearchMovies(searchTerm);
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<MovieEntity>> getTopRated() async {
    try {
      return await remoteDataSource.getTopRated();
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<MovieDetailModel> getDetail(int id) async {
    try {
      return await remoteDataSource.getDetails(id);
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<CastCrewModel>> getCastCrew(int id) async {
    try {
      return await remoteDataSource.getCastCrew(id);
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<RecommendationModel>> getMovieRecommendation(int id) async {
    try {
      return await remoteDataSource.getRecommendation(id);
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<MovieTrailerModel>> getmovieVideo(int id) async {
    try {
      return await remoteDataSource.getmovieVideo(id);
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }
}

import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod_movie_app/models/cast_crew_model.dart';
import 'package:flutter_riverpod_movie_app/models/movie_detail_model.dart';
import 'package:flutter_riverpod_movie_app/models/movie_trailer_model.dart';
import 'package:flutter_riverpod_movie_app/models/recommendation_model.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:http/http.dart';

import '../../repository/api_client.dart';
import '../../repository/movie_remote_data_source.dart';

class MovieRepository {
  final ApiClient _client = ApiClient(Client());
  MovieRemoteDataSource get remoteDataSource =>
      MovieRemoteDataSourceImpl(_client);

  Future<List<MovieEntity>> getComingSoon() async {
    try {
      return await remoteDataSource.getComingSoon();
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<MovieEntity>> getPlayingNow() async {
    try {
      return await remoteDataSource.getPlayingNow();
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<MovieEntity>> getPopular() async {
    try {
      return await remoteDataSource.getPopular();
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<MovieEntity>> getSimilarMovies(int id) async {
    try {
      return await remoteDataSource.getSimilarMovies(id);
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<MovieEntity>> getTrending() async {
    try {
      return await remoteDataSource.getTrending();
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<MovieEntity>> getUpcomingMovies() async {
    try {
      return await remoteDataSource.getUpcomingMovies();
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<MovieEntity>> getTopRated() async {
    try {
      return await remoteDataSource.getTopRated();
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<MovieDetailModel> getDetail(int id) async {
    try {
      return await remoteDataSource.getDetails(id);
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<CastCrewModel>> getCastCrew(int id) async {
    try {
      return await remoteDataSource.getCastCrew(id);
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<RecommendationModel>> getMovieRecommendation(int id) async {
    try {
      return await remoteDataSource.getRecommendation(id);
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<MovieTrailerModel>> getmovieVideo(int id) async {
    try {
      return await remoteDataSource.getmovieVideo(id);
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
}

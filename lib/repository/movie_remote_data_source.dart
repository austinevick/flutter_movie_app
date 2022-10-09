import 'package:flutter_riverpod_movie_app/models/cast_crew_model.dart';
import 'package:flutter_riverpod_movie_app/models/movie_detail_model.dart';
import 'package:flutter_riverpod_movie_app/models/movie_model.dart';
import 'package:flutter_riverpod_movie_app/models/movie_result_model.dart';
import 'package:flutter_riverpod_movie_app/models/movie_trailer_model.dart';
import 'package:flutter_riverpod_movie_app/models/recommendation_model.dart';

import 'api_client.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getComingSoon();
  Future<List<MovieModel>> getUpcomingMovies();
  Future<List<MovieModel>> getPlayingNow();
  Future<List<MovieModel>> getSimilarMovies(int id);
  Future<List<MovieModel>> getTopRated();
  Future<MovieDetailModel> getDetails(int id);
  Future<List<CastCrewModel>> getCastCrew(int id);
  Future<List<RecommendationModel>> getRecommendation(int id);
  Future<List<MovieTrailerModel>> getmovieVideo(int id);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;
  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get('trending/movie/day');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies!;
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final response = await _client.get('movie/popular');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies!;
  }

  @override
  Future<List<MovieModel>> getComingSoon() async {
    final response = await _client.get('movie/upcoming');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies!;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
    final response = await _client.get('movie/now_playing');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies!;
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    final response = await _client.get('movie/top_rated');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies!;
  }

  @override
  Future<MovieDetailModel> getDetails(int id) async {
    final response = await _client.get('movie/$id');
    final movies = MovieDetailModel.fromJson(response);
    print(movies);
    return movies;
  }

  @override
  Future<List<CastCrewModel>> getCastCrew(int id) async {
    List<CastCrewModel> cast = [];
    final response = await _client.get('movie/$id/credits');
    List<dynamic> casts = response['cast'];
    casts.forEach((json) => cast.add(CastCrewModel.fromJson(json)));
    return cast;
  }

  @override
  Future<List<RecommendationModel>> getRecommendation(int id) async {
    final response = await _client.get('movie/$id/recommendations');
    final movies = RecommendationResult.fromJson(response).results;
    print(movies);
    return movies!;
  }

  @override
  Future<List<MovieTrailerModel>> getmovieVideo(int id) async {
    final response = await _client.get('movie/$id/videos');
    final movies = MovieTrailerResult.fromMap(response).results;
    print(movies);
    return movies!;
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    final response = await _client.get('movie/upcoming');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies!;
  }


  @override
  Future<List<MovieModel>> getSimilarMovies(int id) async {
    final response = await _client.get('movie/$id/similar');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies!;
  }
}

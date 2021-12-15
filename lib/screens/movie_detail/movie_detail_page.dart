import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_constant.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_detail_entity.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

FutureProvider<MovieDetailEntity> _movieDetailProvider({required int? id}) =>
    FutureProvider<MovieDetailEntity>((ref) async {
      final movieRef = ref.read(movieProvider);
      final movies = await movieRef.getMovieDetail(id: id!);
      return movies;
    });

class MovieDetailPage extends StatelessWidget {
  final int id;

  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final movie = watch.watch(_movieDetailProvider(id: id));
      return SafeArea(
          child: Scaffold(
              body: movie.when(
        data: (movies) => Text(movies.title!),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(
            child: SpinKitDoubleBounce(
          color: Colors.grey,
        )),
      )));
    });
  }

  Widget buildPosterImage(MovieDetailEntity movies) => CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: '${ApiConstants.BASE_IMAGE_URL}${movies.posterPath}',
      placeholder: (context, url) => const Center(
              child: SpinKitDoubleBounce(
            color: Colors.grey,
          )));
}

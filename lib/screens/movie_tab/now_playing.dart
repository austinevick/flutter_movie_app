import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_constant.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/widgets/movie_list_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _nowPlayingMovieFutureProvider = FutureProvider((ref) async {
  final movieRef = ref.read(movieProvider);
  final movies = await movieRef.getPlayingNowMovies();
  return movies;
});

class NowPlayingMovieTab extends ConsumerWidget {
  final List<MovieEntity>? movies;

  const NowPlayingMovieTab(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final movie = watch.watch(_nowPlayingMovieFutureProvider);
    return movie.when(
        data: (movies) => SizedBox(height: 230, child: MovieListView(movies)),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(
                child: SpinKitDoubleBounce(
              color: Colors.grey,
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/widgets/movie_list_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _popularMovieFutureProvider = FutureProvider((ref) async {
  final movieRef = ref.read(movieProvider);
  final movies = await movieRef.getPopularMovies();
  return movies;
});

class PopularMovieTab extends ConsumerWidget {
  final List<MovieEntity>? movies;

  const PopularMovieTab(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final movie = ref.watch(_popularMovieFutureProvider);
    return movie.when(
        data: (movies) => SizedBox(height: 230, child: MovieListView(movies)),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(
                child: SpinKitDoubleBounce(
              color: Colors.grey,
            )));
  }
}

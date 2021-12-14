import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_constant.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _comingSoonMovieFutureProvider = FutureProvider((ref) async {
  final movieRef = ref.read(movieProvider);
  final movies = await movieRef.getComingSoonMovies();
  return movies;
});

class ComingSoonMovieTab extends ConsumerWidget {
  final List<MovieEntity>? movies;

  const ComingSoonMovieTab(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final movie = watch.watch(_comingSoonMovieFutureProvider);
    return movie.when(
        data: (movies) => SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            '${ApiConstants.BASE_IMAGE_URL}${movies[i].posterPath}',
                        placeholder: (context, url) => const Center(
                                child: SpinKitDoubleBounce(
                              color: Colors.grey,
                            ))),
                  ),
                ),
              ),
            ),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(
                child: SpinKitDoubleBounce(
              color: Colors.grey,
            )));
  }
}

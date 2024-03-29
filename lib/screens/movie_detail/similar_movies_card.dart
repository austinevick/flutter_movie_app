import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_detail/movie_detail_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/constant.dart';

final _similarMoviesFutureProvider = FutureProvider.family((ref, int id) async {
  final movieRef = ref.read(movieProvider);
  final movies = await movieRef.getSimilarMovies(id);
  return movies;
});

class SimilarMoviesCard extends StatelessWidget {
  final int? id;
  const SimilarMoviesCard({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return watch.watch(_similarMoviesFutureProvider(id!)).when(
            data: (movie) => SizedBox(
                height: 150,
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                          movie.length,
                          (i) => GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            MovieDetailPage(id: movie[i].id))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            '$BASE_IMAGE_URL${movie[i].posterPath}',
                                        errorWidget: (context, error, _) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          'assets/app_logo.png')),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                        placeholder: (context, url) =>
                                            const Center(
                                                child: SpinKitDoubleBounce(
                                              color: Colors.grey,
                                            ))),
                                  ),
                                ),
                              ))),
                )),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(
                    child: SpinKitDoubleBounce(
                  color: Colors.grey,
                )));
      },
    );
  }
}

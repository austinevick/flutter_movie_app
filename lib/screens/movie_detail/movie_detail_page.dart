import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/constant.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/movie_detail_model.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_detail/movie_detail_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _movieDetailsProvider = FutureProvider.family((ref, int id) async {
  return ref.read(movieProvider).getMovieDetails(id);
});

class MovieDetailPage extends StatelessWidget {
  final int? id;

  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getImage(MovieDetailModel movie) =>
        '$BASE_IMAGE_URL${movie.posterPath}';
    return Consumer(builder: (context, watch, child) {
      return SafeArea(
          child: Scaffold(
        body: watch.watch(_movieDetailsProvider(id!)).when(
              error: (error, stackTrace) => const Center(
                child: Text('Something went wrong'),
              ),
              loading: () => const Center(
                  child: SpinKitDoubleBounce(
                color: Colors.grey,
              )),
              data: (movie) => LayoutBuilder(builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.black.withOpacity(0),
                            Colors.black.withOpacity(0.8),
                            Colors.black,
                            Colors.black,
                            Colors.black,
                          ])),
                      child: MovieDetailWidget(constraints, movie)),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: const ColorFilter.mode(
                              Colors.black54, BlendMode.darken),
                          alignment: Alignment.topCenter,
                          image: NetworkImage(getImage(movie)))),
                );
              }),
            ),
      ));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/data_source/movie_local_data_source.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'favorite_movies_card.dart';

final _movieDataSourceFutureProvider = FutureProvider((ref) async {
  return ref.watch(movieLocalDataSourceProvider).getMovies();
});

class FavouriteMoviesScreen extends StatelessWidget {
  const FavouriteMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      return SafeArea(
          child: Scaffold(
              body: watch.watch(_movieDataSourceFutureProvider).when(
                  error: (error, stackTrace) =>
                      const Center(child: Text('No Internet Connection')),
                  loading: () => const Center(
                          child: SpinKitDoubleBounce(
                        color: Colors.grey,
                      )),
                  data: (movies) => CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            floating: true,
                            title: const Text('Favourite Movies'),
                            actions: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search)),
                            ],
                          ),
                          SliverList(
                              delegate: SliverChildListDelegate.fixed(
                                  List.generate(
                                      movies.length,
                                      (i) => FavoriteMoviesCard(
                                          movies: movies[i]))))
                        ],
                      ))));
    });
  }
}

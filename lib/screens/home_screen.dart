import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_carousel/movie_carousel_widget.dart';
import 'package:flutter_riverpod_movie_app/screens/top_rated/top_rated_movies_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'movie_tab/movie_tabs.dart';

final movieFutureProvider = FutureProvider((ref) async {
  final movieRef = ref.read(movieProvider);
  final movies = await movieRef.getTrendingMovies();
  return movies;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    return SafeArea(
        child: Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  title: const Text('Movies'),
                  actions: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                  ],
                )
              ],
          body: watch.watch(movieFutureProvider).when(
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Center(
                    child: SpinKitDoubleBounce(
                  color: Colors.grey,
                )),
                data: (movies) {
                  return RefreshIndicator(
                    onRefresh: () =>
                        watch.read(movieProvider).getTrendingMovies(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            const Text(
                              'Trending',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            MovieCarouselWidget(
                              movies: movies,
                            ),
                            const SizedBox(height: 16),
                            const MovieTabs(),
                            const SizedBox(height: 12),
                            const Text(
                              'Top Rated',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 12),
                            const TopRatedMovieCard()
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
    ));
  }
}

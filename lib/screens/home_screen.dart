import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_carousel/movie_carousel_widget.dart';
import 'package:flutter_riverpod_movie_app/screens/top_rated/top_rated_movies_card.dart';
import 'package:flutter_riverpod_movie_app/screens/upcoming/upcoming_movies_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'favourite_movies/favourite_movies_screen.dart';
import 'movie_search_screen.dart';
import 'movie_tab/movie_tabs.dart';
import 'widgets/movie_header_text.dart';

final _movieFutureProvider = FutureProvider((ref) async {
  final movieRef = ref.read(movieProvider);
  final movies = await movieRef.getTrendingMovies();
  return movies;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
            body: ref.watch(_movieFutureProvider).when(
                error: (error, stackTrace) =>
                    const Center(child: Text('No Internet Connection')),
                loading: () => const Center(
                        child: SpinKitDoubleBounce(
                      color: Colors.grey,
                    )),
                data: (movies) => CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          centerTitle: true,
                          floating: true,
                          title: const Text('Movies'),
                          actions: [
                            IconButton(
                                onPressed: () => showSearch(
                                    context: context,
                                    delegate: MovieSearchScreen()),
                                icon: const Icon(Icons.search)),
                            // IconButton(
                            //     onPressed: () => Navigator.of(context).push(
                            //         MaterialPageRoute(
                            //             builder: (ctx) =>
                            //                 const FavouriteMoviesScreen())),
                            //     icon: const Icon(Icons.favorite)),
                            // const SizedBox(width: 8)
                          ],
                        ),
                        SliverList(
                            delegate: SliverChildListDelegate.fixed([
                          RefreshIndicator(
                            onRefresh: () =>
                                ref.read(movieProvider).getTrendingMovies(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12),
                                const MovieHeaderText(text: 'Trending'),
                                const SizedBox(height: 12),
                                MovieCarouselWidget(
                                  movies: movies,
                                ),
                                const SizedBox(height: 16),
                                const MovieTabs(),
                                const SizedBox(height: 12),
                                const MovieHeaderText(
                                  text: 'Top Rated',
                                ),
                                const SizedBox(height: 12),
                                const TopRatedMovieCard(),
                                const SizedBox(height: 12),
                                const MovieHeaderText(text: 'Upcoming'),
                                const SizedBox(height: 12),
                                const UpcomingMoviesCard()
                              ],
                            ),
                          )
                        ]))
                      ],
                    ))));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_carousel/movie_carousel_widget.dart';
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
          appBar: AppBar(title: const Text('Movies'), actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ]),
          body: watch.watch(movieFutureProvider).when(
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Center(
                    child: SpinKitDoubleBounce(
                  color: Colors.grey,
                )),
                data: (movies) {
                  return Column(
                    children: [
                      const SizedBox(height: 12),
                      MovieCarouselWidget(
                        movies: movies,
                      ),
                      const SizedBox(height: 16),
                      const MovieTabs()
                    ],
                  );
                },
              )),
    );
  }
}

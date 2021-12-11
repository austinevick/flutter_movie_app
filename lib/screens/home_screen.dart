import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_carousel/movie_carousel_widget.dart';

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
          body: watch.watch(movieFutureProvider).when(
              data: (movies) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.6,
                      child: MovieCarouselWidget(
                        movies: movies,
                        defaultIndex: watch.read(movieProvider).defaultIndex,
                      ),
                    ),
                    const FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      heightFactor: 0.4,
                      child: Placeholder(),
                    )
                  ],
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ))),
    );
  }
}

/*
Stack(
                        fit: StackFit.expand,
                        children: const [
                          FractionallySizedBox(
                            alignment: Alignment.topCenter,
                            heightFactor: 0.6,
                            child: MovieCarouselWidget(),
                          ),
                          FractionallySizedBox(
                            alignment: Alignment.bottomCenter,
                            heightFactor: 0.4,
                            child: Placeholder(),
                          )
                        ],
                      );
*/
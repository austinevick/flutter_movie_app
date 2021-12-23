import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/widgets/movie_list_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _upcomingMoviesFutureProvider = FutureProvider((ref) async {
  final movieRef = ref.read(movieProvider);
  final movies = await movieRef.getUpcomingMovies();
  return movies;
});

class UpcomingMoviesCard extends StatelessWidget {
  const UpcomingMoviesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      return watch.watch(_upcomingMoviesFutureProvider).when(
          data: (movies) => SizedBox(height: 230, child: MovieListView(movies)),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(
                  child: SpinKitDoubleBounce(
                color: Colors.grey,
              )));
    });
  }
}

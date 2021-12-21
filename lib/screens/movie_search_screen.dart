import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _movieSearchProvider =
    FutureProvider.family((ref, String searchTerm) async {
  return ref.read(movieProvider).getSearchMovies(searchTerm);
});

class MovieSearchScreen extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff191a32)));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          color: query.isEmpty ? Colors.grey : Colors.white,
          onPressed: () => query = '',
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return watch.watch(_movieSearchProvider(query)).when(
            data: (movies) {
              return Column(
                children:
                    List.generate(movies.length, (i) => Text(movies[i].title!)),
              );
            },
            error: (error, stackTrace) => Text('Error loading'),
            loading: () => const Center(
                    child: SpinKitDoubleBounce(
                  color: Colors.grey,
                )));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

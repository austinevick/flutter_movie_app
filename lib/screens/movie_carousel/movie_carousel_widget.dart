import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/screens/widgets/movie_app_bar.dart';
import 'movie_page_view.dart';

class MovieCarouselWidget extends StatelessWidget {
  final List<MovieEntity>? movies;
  final int defaultIndex;
  const MovieCarouselWidget({Key? key, this.movies, this.defaultIndex = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MovieAppBar(),
        MoviePageView(
          initialPage: defaultIndex,
          movies: movies,
        )
      ],
    );
  }
}

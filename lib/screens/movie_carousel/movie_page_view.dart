import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';

import 'animated_movie_card.dart';

class MoviePageView extends StatefulWidget {
  final List<MovieEntity>? movies;
  final int initialPage;
  const MoviePageView({Key? key, this.movies, required this.initialPage})
      : super(key: key);

  @override
  _MoviePageViewState createState() => _MoviePageViewState();
}

class _MoviePageViewState extends State<MoviePageView> {
  late PageController controller;
  @override
  void initState() {
    controller = PageController(
        initialPage: widget.initialPage,
        keepPage: false,
        viewportFraction: 0.7);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: MediaQuery.of(context).size.height / 3,
      child: PageView.builder(
        onPageChanged: (index) {},
        pageSnapping: true,
        itemCount: widget.movies!.length,
        itemBuilder: (BuildContext context, int index) {
          final movie = widget.movies![index];
          return AnimatedMovieCardWidget(
              controller: controller,
              index: index,
              movieId: movie.id,
              posterPath: movie.posterPath);
        },
      ),
    );
  }
}

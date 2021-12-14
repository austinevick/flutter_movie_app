import 'package:flutter/material.dart';

import 'movie_card_widget.dart';

class AnimatedMovieCardWidget extends StatelessWidget {
  final int? index;
  final int? movieId;
  final String? posterPath;
  final PageController controller;
  const AnimatedMovieCardWidget(
      {Key? key,
      this.index,
      required this.controller,
      this.movieId,
      this.posterPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double value = 1;
          if (controller.position.haveDimensions) {
            value = (controller.page! - index!);
            value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
            return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    height: Curves.easeIn.transform(value) * 280,
                    width: 220,
                    child: child));
          } else {
            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height:
                    Curves.easeIn.transform(index == 0 ? value : value * 0.5) *
                        100,
                width: 100,
                child: child,
              ),
            );
          }
        },
        child: MovieCardWidget(
          movieId: movieId,
          posterPath: posterPath,
        ));
  }
}

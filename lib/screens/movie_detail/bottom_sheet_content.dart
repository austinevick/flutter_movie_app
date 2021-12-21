import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/movie_detail_model.dart';

import 'movie_cast_card.dart';
import 'movie_recommendation_card.dart';

class BottomSheetContent extends StatelessWidget {
  final MovieDetailModel movie;
  final BoxConstraints constraints;
  const BottomSheetContent(this.movie, this.constraints, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(movie.title),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.keyboard_arrow_down,
                      size: 35, color: Colors.white))
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8, top: 8),
                    child: Text(
                      'Cast',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                      height: 200,
                      width: constraints.maxWidth,
                      child: MovieCastCard(id: movie.id)),
                  const Padding(
                    padding: EdgeInsets.only(left: 8, top: 8),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Recommendation',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                  MovieRecommendationCard(id: movie.id)
                ],
              )),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final int? id;
  final MovieModel? model;
  const MovieDetailPage({Key? key, this.id, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [Text('$id')],
        ),
      ),
    );
  }
}

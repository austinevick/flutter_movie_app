import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_constant.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/cast_crew_model.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'movie_cast_card.dart';

class MovieDetailPage extends StatefulWidget {
  final MovieEntity movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [
                        const Color(0xff191a32).withOpacity(0),
                        const Color(0xff191a32).withOpacity(0.8)
                      ])),
                  child: Stack(
                    children: [
                      buildPosterImage(widget.movie.posterPath!),
                      Positioned(
                        bottom: 30,
                        right: 0,
                        left: 20,
                        child: Text(
                          widget.movie.title!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(),
                        child: Text(
                          'Overview',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ),
                    ),
                    Text(widget.movie.overview!),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Cast',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ),
                    ),
                    MovieCastCard(id: widget.movie.id)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPosterImage(String image) => CachedNetworkImage(
      colorBlendMode: BlendMode.darken,
      color: Colors.black12,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      imageUrl: '${ApiConstants.BASE_IMAGE_URL}$image',
      placeholder: (context, url) => const Center(
              child: SpinKitDoubleBounce(
            color: Colors.grey,
          )));
}

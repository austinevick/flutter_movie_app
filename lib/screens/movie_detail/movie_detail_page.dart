import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_constant.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/movie_detail_model.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_detail/movie_recommendation_card.dart';
import 'package:flutter_riverpod_movie_app/screens/watch_video/videos_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'movie_cast_card.dart';

final _movieDetailsProvider = FutureProvider.family((ref, int id) async {
  return ref.read(movieProvider).getMovieDetails(id);
});

class MovieDetailPage extends StatefulWidget {
  final int? id;

  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool isExpanded = false;

  String getImage(MovieDetailModel movie) =>
      '${ApiConstants.BASE_IMAGE_URL}${movie.posterPath}';

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Consumer(builder: (context, watch, child) {
      return SafeArea(
          child: Scaffold(
        body: watch.watch(_movieDetailsProvider(widget.id!)).when(
              error: (error, stackTrace) => const Center(
                child: Text('Error fetching movies'),
              ),
              loading: () => const Center(
                  child: SpinKitDoubleBounce(
                color: Colors.grey,
              )),
              data: (movie) => LayoutBuilder(builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0.8),
                          Colors.black,
                          Colors.black,
                          Colors.black,
                        ])),
                    child: isExpanded
                        ? buildContent2(constraints, movie)
                        : buildContent1(constraints, movie),
                  ),
                  decoration: isExpanded
                      ? null
                      : BoxDecoration(
                          image: DecorationImage(
                              colorFilter: const ColorFilter.mode(
                                  Colors.black54, BlendMode.darken),
                              alignment: Alignment.topCenter,
                              image: NetworkImage(getImage(movie)))),
                );
              }),
            ),
      ));
    });
  }

  Widget buildContent2(BoxConstraints constraints, MovieDetailModel movie) =>
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    backgroundColor: Color(0xff333742),
                    child: Icon(Icons.keyboard_backspace, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Text(movie.title),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(getImage(movie),
                        height: 50, width: 50, fit: BoxFit.cover),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: ListView(
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Cast',
                            style: TextStyle(color: Colors.black),
                          ),
                          IconButton(
                              splashColor: Colors.black,
                              onPressed: () {
                                setState(() => isExpanded = false);
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                                color: Colors.black,
                              ))
                        ],
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

  Widget buildContent1(BoxConstraints constraints, MovieDetailModel movie) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    backgroundColor: Color(0xff333742),
                    child: Icon(Icons.keyboard_backspace, color: Colors.white),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
              ],
            ),
            const Spacer(flex: 7),
            Center(
                child: Text(
              movie.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: movie.genres
                  .map((e) => Text(
                        e.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                movie.releaseDate,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Release Date',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(height: 25),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Overview',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                )),
            const SizedBox(height: 8),
            Text(
              movie.overview,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(height: 10),
            VideosWidget(id: movie.id),
            Center(
                child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () => setState(() => isExpanded = true),
                    child: const Icon(Icons.keyboard_arrow_down))),
          ],
        ),
      );
}

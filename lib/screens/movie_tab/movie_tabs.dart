import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_constant.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/home_screen.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_tab/popular_movie_tab.dart';

import 'coming_soon.dart';
import 'now_playing.dart';

class MovieTabs extends StatefulWidget {
  const MovieTabs({Key? key}) : super(key: key);

  @override
  State<MovieTabs> createState() => _MovieTabsState();
}

class _MovieTabsState extends State<MovieTabs> {
  int currentIndex = 0;
  final tabs = ['Popular', 'Now', 'Soon'];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final movies = watch.watch(movieProvider).movies;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              tabs.length,
              (i) => AnimatedContainer(
                duration: const Duration(seconds: 1),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: currentIndex == i
                                ? Colors.red
                                : Colors.transparent))),
                child: MaterialButton(
                  onPressed: () => setState(() => currentIndex = i),
                  child: Text(tabs[i]),
                ),
              ),
            ),
          ),
          buildMovieTabs(movies)
        ],
      );
    });
  }

  buildMovieTabs(List<MovieEntity>? movies) {
    switch (currentIndex) {
      case 0:
        return PopularMovieTab(movies);
      case 1:
        return NowPlayingMovieTab(movies);
      case 2:
        return ComingSoonMovieTab(movies);
    }
    return movies;
  }
}


/*
 SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies!.length,
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        '${ApiConstants.BASE_IMAGE_URL}${widget.movies![i].posterPath}',
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
          )


*/
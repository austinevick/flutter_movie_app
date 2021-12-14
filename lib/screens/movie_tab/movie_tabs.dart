import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
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
  final tabs = ['Popular', 'Now playing', 'Coming soon'];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final movies = watch.watch(movieProvider).movies;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                tabs.length,
                (i) => GestureDetector(
                  onTap: () => setState(() => currentIndex = i),
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    duration: const Duration(milliseconds: 800),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        width: 2,
                        color:
                            currentIndex == i ? Colors.red : Colors.transparent,
                      )),
                    ),
                    child: Text(
                      tabs[i],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: currentIndex == i ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
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

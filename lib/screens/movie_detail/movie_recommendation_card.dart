import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_constant.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _movieRecommendationProvider = FutureProvider.family((ref, int id) async {
  return ref.read(movieProvider).getMovieRecommendation(id);
});

class MovieRecommendationCard extends StatelessWidget {
  final int? id;
  const MovieRecommendationCard({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      return watch
          .watch(
            _movieRecommendationProvider(id!),
          )
          .when(
              data: (movie) => SizedBox(
                  height: 230,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            movie.length,
                            (i) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 230,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                '${ApiConstants.BASE_IMAGE_URL}${movie[i].posterPath}'))),
                                  ),
                                ))),
                  )),
              error: (error, stackTrace) => Text('Error loading'),
              loading: () => const Center(
                      child: SpinKitDoubleBounce(
                    color: Colors.grey,
                  )));
    });
  }
}
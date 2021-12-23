import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_constant.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieSearchListView extends StatelessWidget {
  final List<MovieEntity>? movies;
  const MovieSearchListView({Key? key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies!.length,
      itemBuilder: (context, i) {
        final movie = movies![i];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 150,
                    imageUrl:
                        '${ApiConstants.BASE_IMAGE_URL}${movies![i].posterPath}',
                    placeholder: (context, url) => const Center(
                            child: SpinKitDoubleBounce(
                          color: Colors.grey,
                        ))),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(movie.title!))
            ],
          ),
        );
      },
    );
  }
}

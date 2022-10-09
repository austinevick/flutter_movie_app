import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_detail/movie_detail_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/constant.dart';

class MovieSearchListView extends StatelessWidget {
  final List<MovieEntity>? movies;
  const MovieSearchListView({Key? key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies!.length,
      itemBuilder: (context, i) {
        final movie = movies![i];
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => MovieDetailPage(id: movie.id))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 150,
                      imageUrl: '$BASE_IMAGE_URL${movies![i].posterPath}',
                      placeholder: (context, url) => const Center(
                              child: SpinKitDoubleBounce(
                            color: Colors.grey,
                          ))),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(movie.title!))
              ],
            ),
          ),
        );
      },
    );
  }
}

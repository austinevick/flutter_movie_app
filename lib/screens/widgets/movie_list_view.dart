import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_constant.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_detail/movie_detail_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../common/extension.dart';

class MovieListView extends StatelessWidget {
  final List<MovieEntity>? movies;

  const MovieListView(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: movies!.length,
      itemBuilder: (context, i) => GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => MovieDetailPage(
                  movie: movies![i],
                ))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        '${ApiConstants.BASE_IMAGE_URL}${movies![i].posterPath}',
                    placeholder: (context, url) => const Center(
                            child: SpinKitDoubleBounce(
                          color: Colors.grey,
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(movies![i].title!.trimText()),
            )
          ],
        ),
      ),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(width: 10),
    );
  }
}

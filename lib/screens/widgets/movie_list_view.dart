import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_detail/movie_detail_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../common/constant.dart';
import '../../common/extension.dart';

class MovieListView extends StatelessWidget {
  final List<MovieEntity>? movies;
  final Axis? scrollDirection;
  const MovieListView(this.movies, {Key? key, this.scrollDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: scrollDirection ?? Axis.horizontal,
      itemCount: movies!.length,
      itemBuilder: (context, i) => GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => MovieDetailPage(
                  id: movies![i].id,
                ))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: '$BASE_IMAGE_URL${movies![i].posterPath}',
                    errorWidget: (context, error, _) => Container(
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('assets/app_logo.png')),
                              borderRadius: BorderRadius.circular(10)),
                        ),
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

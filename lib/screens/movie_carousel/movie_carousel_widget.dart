import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/data/core/constant.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_detail/movie_detail_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieCarouselWidget extends StatelessWidget {
  final List<MovieEntity>? movies;

  const MovieCarouselWidget({Key? key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
              viewportFraction: 0.4, height: 250, enlargeCenterPage: true),
          itemCount: movies!.length,
          itemBuilder: (context, index, realIndex) {
            final movie = movies![index];
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => MovieDetailPage(id: movie.id!))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
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
            );
          },
        ),
      ],
    );
  }
}

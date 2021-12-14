import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_constant.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
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
              height: 250, viewportFraction: 0.5, enlargeCenterPage: true),
          itemCount: movies!.length,
          itemBuilder: (context, index, realIndex) {
            final movie = movies![index];
            return SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        '${ApiConstants.BASE_IMAGE_URL}${movie.posterPath}',
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

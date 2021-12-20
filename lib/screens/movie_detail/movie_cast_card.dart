import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_constant.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/cast_crew_model.dart';
import 'package:flutter_riverpod_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _castCrewProvider = FutureProvider.family((ref, int id) async {
  return ref.read(movieProvider).getMovieCastCrew(id);
});

class MovieCastCard extends StatelessWidget {
  final int? id;
  const MovieCastCard({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getImage(CastCrewModel cast) =>
        '${ApiConstants.BASE_IMAGE_URL}${cast.profilePath}';

    return Consumer(builder: (context, watch, child) {
      return watch.watch(_castCrewProvider(id!)).when(
          data: (casts) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(casts.length, (i) {
                    final cast = casts[i];
                    return Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          height: 180,
                          width: 100,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: getImage(cast),
                                    placeholder: (context, url) => const Center(
                                            child: SpinKitDoubleBounce(
                                          color: Colors.grey,
                                        ))),
                              ),
                              Text(cast.name!,
                                  style: const TextStyle(color: Colors.black),
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        ));
                  }),
                ),
              ),
          error: (error, stackTrace) => Text('Error loading'),
          loading: () => const Center(
                  child: SpinKitDoubleBounce(
                color: Colors.grey,
              )));
    });
  }
}

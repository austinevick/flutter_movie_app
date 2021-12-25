import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/constant.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_db_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _movieDBFutureProvider = FutureProvider((ref) async {
  return ref.read(movieDBProvider).getFavouriteMovies();
});

class FavouriteMoviesScreen extends StatelessWidget {
  const FavouriteMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Consumer(builder: (context, watch, _) {
        return SafeArea(
            child: Scaffold(
                body: watch.watch(_movieDBFutureProvider).when(
                    error: (error, stackTrace) =>
                        const Center(child: Text('No Internet Connection')),
                    loading: () => const Center(
                            child: SpinKitDoubleBounce(
                          color: Colors.grey,
                        )),
                    data: (movies) => CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              floating: true,
                              title: const Text('Favourite Movies'),
                              actions: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.search)),
                              ],
                            ),
                            SliverList(
                                delegate:
                                    SliverChildListDelegate.fixed(List.generate(
                                        movies.length,
                                        (i) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 150,
                                                    width: 100,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl:
                                                              '$BASE_IMAGE_URL${movies[i].image}',
                                                          placeholder: (context,
                                                                  url) =>
                                                              const Center(
                                                                  child:
                                                                      SpinKitDoubleBounce(
                                                                color:
                                                                    Colors.grey,
                                                              ))),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Column(
                                                    children: [
                                                      Text(movies[i].title!),
                                                      Text(movies[i]
                                                          .date
                                                          .toString()),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ))))
                          ],
                        ))));
      });
    });
  }
}

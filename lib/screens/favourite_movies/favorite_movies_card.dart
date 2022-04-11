// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod_movie_app/data/core/constant.dart';
// import 'package:flutter_riverpod_movie_app/data/core/data_source/movie_local_data_source.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import '../../domain/movie_database/movie_db_model.dart';

// class FavoriteMoviesCard extends StatelessWidget {
//   final MovieDBModel? movies;
//   const FavoriteMoviesCard({Key? key, this.movies}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, watch, _) {
//       return Slidable(
//           key: ValueKey(movies!.id),
//           startActionPane: ActionPane(motion: const BehindMotion(), children: [
//             SlidableAction(
//               onPressed: (context) {
//                 showBarModalBottomSheet(
//                   context: context,
//                   builder: (context) => Container(
//                       color: Colors.white,
//                       height: 200,
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 10),
//                           const Text(
//                               'Are you sure you want to delete this item'),
//                           OutlinedButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                                 watch
//                                     .read(movieLocalDataSourceProvider)
//                                     .deleteMovie(movies!.id!);
//                               },
//                               child: const Text('DELETE')),
//                           OutlinedButton(
//                               onPressed: () => Navigator.of(context).pop(),
//                               child: const Text('CANCEL')),
//                         ],
//                       )),
//                 );
//               },
//               backgroundColor: const Color(0xFFFE4A49),
//               foregroundColor: Colors.white,
//               icon: Icons.delete,
//               label: 'Delete',
//             ),
//           ]),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 SizedBox(
//                   height: 150,
//                   width: 100,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: CachedNetworkImage(
//                         fit: BoxFit.cover,
//                         imageUrl: '$BASE_IMAGE_URL${movies!.image}',
//                         placeholder: (context, url) => const Center(
//                                 child: SpinKitDoubleBounce(
//                               color: Colors.grey,
//                             ))),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Column(
//                   children: [
//                     Text(movies!.title!),
//                     Text(movies!.date.toString()),
//                   ],
//                 ),
//               ],
//             ),
//           ));
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/provider/movie_provider.dart';
import 'package:flutter_riverpod_movie_app/screens/watch_video/video_arguments.dart';
import 'package:flutter_riverpod_movie_app/screens/watch_video/video_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _movieTrailerProvider = FutureProvider.family((ref, int id) async {
  return ref.read(movieProvider).getmovieVideo(id);
});

class VideosWidget extends StatelessWidget {
  final int? id;
  const VideosWidget({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      return watch.watch(_movieTrailerProvider(id!)).when(
          error: (error, stackTrace) => Container(),
          loading: () => const Center(
                  child: SpinKitDoubleBounce(
                color: Colors.grey,
              )),
          data: (videos) => MaterialButton(
                height: 50,
                minWidth: double.infinity,
                color: Colors.red,
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) =>
                          VideoScreen(arguments: VideoArguments(videos))));
                },
                child: const Text('Watch trailer'),
              ));
    });
  }
}

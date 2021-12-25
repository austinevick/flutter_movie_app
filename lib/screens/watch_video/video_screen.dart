import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/screens/watch_video/video_arguments.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final VideoArguments arguments;
  const VideoScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController controller;
  String _title = '';
  @override
  void initState() {
    _title = widget.arguments.videos![0].name!;
    controller = YoutubePlayerController(
        initialVideoId: widget.arguments.videos![0].key!,
        flags: const YoutubePlayerFlags(autoPlay: true));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            progressIndicatorColor: Colors.red,
            showVideoProgressIndicator: true,
            controller: controller,
          ),
          builder: (context, child) {
            return Column(
              children: [
                child,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                            List.generate(widget.arguments.videos!.length, (i) {
                          final video = widget.arguments.videos![i];
                          return GestureDetector(
                            onTap: () {
                              controller.load(video.key!);
                              controller.play();
                              setState(() => _title = video.name!);
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            const SpinKitDoubleBounce(
                                              color: Colors.grey,
                                            ),
                                        fit: BoxFit.cover,
                                        imageUrl: YoutubePlayer.getThumbnail(
                                            videoId: video.key!,
                                            quality: ThumbnailQuality.high)),
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(video.name!),
                                ))
                              ],
                            ),
                          );
                        })),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/data/core/constant.dart';
import 'package:flutter_riverpod_movie_app/data/core/data_source/movie_local_data_source.dart';
import 'package:flutter_riverpod_movie_app/data/core/models/movie_detail_model.dart';
import 'package:flutter_riverpod_movie_app/screens/movie_detail/bottom_sheet_content.dart';
import 'package:flutter_riverpod_movie_app/screens/watch_video/videos_widget.dart';
import 'package:flutter_riverpod_movie_app/domain/movie_database/movie_db_model.dart';
import 'package:hive/hive.dart';

class MovieDetailWidget extends StatefulWidget {
  final BoxConstraints constraints;
  final MovieDetailModel movie;
  const MovieDetailWidget(this.constraints, this.movie, {Key? key})
      : super(key: key);

  @override
  State<MovieDetailWidget> createState() => _MovieDetailWidgetState();
}

class _MovieDetailWidgetState extends State<MovieDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.keyboard_backspace, size: 28)),
            ],
          ),
          const Spacer(flex: 7),
          Center(
              child: Text(
            widget.movie.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          )),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.movie.genres
                .map((e) => Text(
                      e.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.movie.releaseDate,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Release Date',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Colors.grey),
            ),
          ),
          const SizedBox(height: 25),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Overview',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              )),
          const SizedBox(height: 8),
          Text(
            widget.movie.overview,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(height: 10),
          VideosWidget(id: widget.movie.id),
          Center(
              child: MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () => showModalBottomSheet(
                      isDismissible: false,
                      enableDrag: false,
                      barrierColor: Colors.black.withOpacity(0.3),
                      context: context,
                      builder: (ctx) =>
                          BottomSheetContent(widget.movie, widget.constraints)),
                  child: const Icon(Icons.keyboard_arrow_down))),
        ],
      ),
    );
  }
}

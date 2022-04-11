import 'package:flutter/material.dart';

const String BASE_URL = "https://api.themoviedb.org/3/";
const String API_KEY = "dcb8565b1508cc35b50fbacaf9f52628";
const String BASE_IMAGE_URL = "https://image.tmdb.org/t/p/w500";

SnackBar snackBar(text) => SnackBar(
        content: Row(
      children: [
        Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue[300],
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    ));

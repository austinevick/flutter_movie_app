import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String BASE_URL = "https://api.themoviedb.org/3/";
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

final theme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff191a32),
    ),
    scaffoldBackgroundColor: const Color(0xff191a32),
    textTheme: TextTheme(
        headline6: GoogleFonts.lobster(),
        bodyText2: GoogleFonts.lobster(),
        bodyText1: GoogleFonts.lobster()));

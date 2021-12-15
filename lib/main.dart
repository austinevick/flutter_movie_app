import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xff191a32)),
            scaffoldBackgroundColor: const Color(0xff191a32),
            textTheme: TextTheme(
                bodyText2: GoogleFonts.poppins(),
                bodyText1: GoogleFonts.poppins())),
        home: const HomeScreen(),
      ),
    );
  }
}

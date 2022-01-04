import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/constant.dart';
import 'package:flutter_riverpod_movie_app/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import './domain/movie_database/movie_db_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieDBModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xff191a32)),
            scaffoldBackgroundColor: const Color(0xff191a32),
            textTheme: TextTheme(
                headline6: GoogleFonts.lobster(),
                bodyText2: GoogleFonts.lobster(),
                bodyText1: GoogleFonts.lobster())),
        home: const HomeScreen(),
      ),
    );
  }
}

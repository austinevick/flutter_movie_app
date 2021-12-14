import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/api_client.dart';
import 'package:flutter_riverpod_movie_app/data/core/data_source/movie_remote_data_source.dart';
import 'package:flutter_riverpod_movie_app/domain/repositories/movie_repository.dart';
import 'package:flutter_riverpod_movie_app/screens/home_screen.dart';
import 'package:http/http.dart';

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
        theme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}

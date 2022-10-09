import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_movie_app/apikey.dart';
import 'package:flutter_riverpod_movie_app/common/extension.dart';
import 'package:flutter_riverpod_movie_app/models/movie_model.dart';
import 'package:flutter_riverpod_movie_app/models/movie_result_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../common/constant.dart';
import 'movie_detail/movie_detail_page.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({Key? key}) : super(key: key);

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final controller = TextEditingController();
  final client = Client();
  List<MovieModel> searchResult = [];
  List<MovieModel> movies = [];
  bool isLoading = false;

  Future<void> getSearchMovies() async {
    try {
      setState(() => isLoading = true);

      final response = await client.get(Uri.parse(
          "https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=${controller.text}"));
      if (response.statusCode == 200) {
        setState(() => isLoading = false);
        final json = jsonDecode(response.body);
        List<MovieModel>? movies = MoviesResultModel.fromJson(json).movies;
        setState(() => this.movies = movies!);
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar('Something went wrong'));
      }
    } on SocketException catch (_) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('No internet connection'));
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Material(
            color: const Color(0xff191a32),
            elevation: 4,
            child: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios)),
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    onEditingComplete: () async => await getSearchMovies(),
                    style: GoogleFonts.lobster(fontSize: 16.8),
                    decoration: const InputDecoration(
                        hintText: 'Search movies',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
              child: isLoading
                  ? const Center(
                      child: SpinKitDoubleBounce(
                      color: Colors.grey,
                    ))
                  : movies.isEmpty
                      ? const Center(child: Text('Search movies'))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => MovieDetailPage(
                                          id: movies[i].id,
                                        ))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            '$BASE_IMAGE_URL${movies[i].posterPath}',
                                        placeholder: (context, url) =>
                                            const Center(
                                                child: SpinKitDoubleBounce(
                                              color: Colors.grey,
                                            ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(movies[i].title!.trimText()),
                                )
                              ],
                            ),
                          ),
                          itemCount: movies.length,
                        )),
        ],
      ),
    ));
  }
}

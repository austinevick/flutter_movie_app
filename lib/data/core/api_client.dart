import 'dart:convert';

import 'package:http/http.dart';

import 'constant.dart';

class ApiClient {
  final Client _client;
  ApiClient(this._client);

  dynamic get(String path) async {
    final response = await _client.get(
        Uri.parse('$BASE_URL$path?api_key=$API_KEY'),
        headers: {'content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic getSearchMovies(String searchTerm) async {
    final response = await _client.get(
        Uri.parse('$BASE_URL}search/movie?api_key=$API_KEY&query=$searchTerm'),
        headers: {'content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

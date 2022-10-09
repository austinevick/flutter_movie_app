import 'dart:convert';
import 'package:http/http.dart';
import '../apikey.dart';
import '../common/constant.dart';

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

 
}

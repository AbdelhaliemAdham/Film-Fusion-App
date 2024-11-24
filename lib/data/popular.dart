import 'dart:convert';

import 'package:movie/Models/actor.dart';
import 'package:http/http.dart' as http;
import 'package:movie/helper/constants.dart';

class PopularPeople {
  static Future<List<Actor>> fetchPopularActors() async {
    String baseUrl =
        "https://api.themoviedb.org/3/person/popular?api_key=${Constants.apiKey}";
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final popular = jsonData['results'] as List;
      print("popular Actors $popular");
      return popular.map((json) => Actor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

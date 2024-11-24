import 'dart:convert';

import 'package:movie/Models/Movie.dart';
import 'package:movie/helper/constants.dart';
import 'package:http/http.dart' as http;

class CategoriesApi {
  static String baseUrl =
      "https://api.themoviedb.org/3/genre/movie/list?api_key=${Constants.apiKey}";

  static Future<List<Movies>> fetchCommingMovies() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final movies = jsonData['results'] as List;
      return movies.map((json) => Movies.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

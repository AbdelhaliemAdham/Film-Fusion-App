import 'dart:convert';

import 'package:movie/Models/Movie.dart';
import 'package:movie/helper/constants.dart';
import 'package:http/http.dart' as http;

class SimilarMovies {
  static Future<List<Movies>> fetchSimilarMovies(int movieId) async {
    String baseUrl =
        "https://api.themoviedb.org/3/movie/$movieId/similar?api_key=${Constants.apiKey}";
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

import 'dart:convert';

import 'package:movie/Models/airing_series.dart';
import 'package:movie/helper/constants.dart';
import 'package:http/http.dart' as http;

class AiringSeriesApi {
  static String baseUrl =
      "https://api.themoviedb.org/3/tv/airing_today?api_key=${Constants.apiKey}";

  static Future<List<AiringSeries>> fetchAiringSeries() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final series = jsonData['results'] as List;
      return series.map((json) => AiringSeries.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/genre_model.dart';

class GenreService {
  final String baseUrl;

  GenreService({required this.baseUrl});

  Future<List<Genre>> fetchGenres() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/genres'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final genreResponse = GenreResponse.fromJson(jsonData);
        return genreResponse.genres;
      } else {
        throw Exception('Failed to load genres: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}

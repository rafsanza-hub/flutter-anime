import 'dart:convert';
import '../models/anime_genre_model.dart';
import 'package:http/http.dart' as http;

class AnimeGenreService {
  final String baseUrl = "http://10.0.2.2:3001/otakudesu/";

  Future<AnimeGenreResponse> fetchAnimeList(String genreId,
      {int page = 1}) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/genres/$genreId?page=$page"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AnimeGenreResponse.fromJson(data);
      } else if (response.statusCode == 404) {
        return AnimeGenreResponse.fromJson({
          'data': {'animeList': []},
          'pagination': {
            'currentPage': page,
            'hasPrevPage': page > 1,
            'prevPage': page > 1 ? page - 1 : null,
            'hasNextPage': false,
            'nextPage': null,
            'totalPages': page
          }
        });
      } else {
        throw Exception('Failed to load anime');
      }
    } catch (e) {
      throw Exception('Failed to load anime: $e');
    }
  }
}

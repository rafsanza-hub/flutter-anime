import 'dart:convert';
import 'package:flutter_anime/features/anime_by_genre/models/anime_genre_model.dart';
import 'package:http/http.dart' as http;

class AnimeGenreService {
  final String baseUrl = "http://10.0.2.2:3001/otakudesu/";

  Future<List<Anime>> fetchAnimeList(String genreId) async {
    final response = await http.get(Uri.parse("$baseUrl/genres/$genreId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List animeList = data['data']['animeList'];
      return animeList.map((anime) => Anime.fromJson(anime)).toList();
    } else {
      throw Exception('Failed to load anime');
    }
  }
}

import 'dart:convert';
import 'package:flutter_anime/features/anime/models/anime_model.dart';
import 'package:http/http.dart' as http;

class AnimeService {
  final String baseUrl;

  AnimeService({required this.baseUrl});

  Future<List<Anime>> getAnimes() async {
    final response = await http.get(Uri.parse('$baseUrl/home'));
   

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      // ongoing
      final List<dynamic> ongoingAnimeList = jsonData['data']['ongoing']['animeList'];

      // Konversi ke List<Anime>
      return ongoingAnimeList.map((item) => Anime.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data: ${response.statusCode}');
    }
  }
}
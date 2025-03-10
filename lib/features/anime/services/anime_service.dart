import 'dart:convert';
import '../models/anime_model.dart';
import 'package:http/http.dart' as http;

class AnimeService {
  final String baseUrl;

  AnimeService({required this.baseUrl});

  Future<AnimeList> getAnimes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/home'));

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          return AnimeList.fromJson(jsonData);
        } catch (e) {
          throw Exception('Format JSON tidak sesuai: $e');
        }
      } else {
        throw Exception(
            'Gagal memuat data. Status Code: ${response.statusCode}\nBody: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data: $e');
    }
  }


  Future<List<Anime>> searchAnimes(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/search').replace(
          queryParameters: {'q': query},
        ),
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          final List<dynamic> animeList = jsonData['data']['animeList'];
          return animeList.map((anime) => SearchAnime.fromJson(anime)).toList();
        } catch (e) {
          throw Exception('Format JSON tidak sesuai: $e');
        }
      } else {
        throw Exception(
          'Gagal memuat data. Status Code: ${response.statusCode}\nBody: ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data: $e');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime_detail_model.dart';

class AnimeDetailService {
  final String baseUrl;

  AnimeDetailService({required this.baseUrl});

  Future<AnimeDetailResponse> fetchAnimeDetail(String animeId) async {
    final response = await http.get(Uri.parse('$baseUrl/anime/$animeId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return AnimeDetailResponse.fromJson(jsonData);
    } else {
      throw Exception('Gagal memuat data: ${response.statusCode}');
    }
  }
}
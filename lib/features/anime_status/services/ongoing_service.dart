import 'dart:convert';

import 'package:flutter_anime/features/anime_status/models/ongoing_model.dart';
import 'package:http/http.dart' as http;

class StatusService {
  final String baseUrl;

  StatusService({required this.baseUrl});

  // Method untuk mengambil data ongoing anime dengan pagination
  Future<StatusAnimeResponse> getOngoingAnime(int page) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/ongoing'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return StatusAnimeResponse.fromJson(jsonData);
      } else {
        throw Exception(
            'Gagal memuat data. Status Code: ${response.statusCode}\nBody: ${response.body}');
      }
    } catch (e) {
      print(e);
      throw Exception('Terjadi kesalahan saat memuat data: $e');
    }
  }

  Future<StatusAnimeResponse> getCompletedAnime(int page) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/completed'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return StatusAnimeResponse.fromJson(jsonData);
      } else {
        throw Exception(
            'Gagal memuat data. Status Code: ${response.statusCode}\nBody: ${response.body}');
      }
    } catch (e) {
      print(e);
      throw Exception('Terjadi kesalahan saat memuat data: $e');
    }
  }
}

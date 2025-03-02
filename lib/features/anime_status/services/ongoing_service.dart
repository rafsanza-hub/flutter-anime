import 'dart:convert';

import '../models/ongoing_model.dart';
import 'package:http/http.dart' as http;

class StatusService {
  final String baseUrl;

  StatusService({required this.baseUrl});

  // Method untuk mengambil data ongoing anime dengan pagination
  Future<StatusAnimeResponse> getOngoingAnime(int page) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/ongoing?page=$page'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return StatusAnimeResponse.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        return StatusAnimeResponse.fromJson({
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
        throw Exception(
            'Gagal memuat data. Status Code: ${response.statusCode}\nBody: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data: $e');
    }
  }

  Future<StatusAnimeResponse> getCompletedAnime(int page) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/completed?page=$page'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return StatusAnimeResponse.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        return StatusAnimeResponse(
          animeList: [], // List kosong
          pagination: Pagination(
            currentPage: page,
            hasPrevPage: page > 1,
            prevPage: page > 1 ? page - 1 : null,
            hasNextPage: false,
            nextPage: null,
            totalPages: page,
          ),
        );
      } else {
        throw Exception(
            'Gagal memuat data. Status Code: ${response.statusCode}\nBody: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data: $e');
    }
  }
}

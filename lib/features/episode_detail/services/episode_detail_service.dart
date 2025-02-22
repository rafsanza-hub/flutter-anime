import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/episode_detail_model.dart';

class EpisodeDetailService {
  final String baseUrl;

  EpisodeDetailService({required this.baseUrl});

  Future<EpisodeDetailResponse> fetchEpisodeDetail(String episodeId) async {
    final response = await http.get(Uri.parse('$baseUrl/episode/$episodeId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return EpisodeDetailResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load episode detail: ${response.statusCode}');
    }
  }
}
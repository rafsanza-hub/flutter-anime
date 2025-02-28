import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/episode_detail_model.dart';
import '../services/video_extractor_service.dart';

class EpisodeDetailService {
  final String baseUrl;

  EpisodeDetailService({required this.baseUrl});

  Future<EpisodeDetailResponse> fetchEpisodeDetail(String episodeId) async {
    try {
      // Step 1: Ambil data episode
      final response = await http.get(Uri.parse('$baseUrl/episode/$episodeId'));

      if (response.statusCode != 200) {
        throw Exception('Failed to load episode detail: ${response.statusCode}');
      }

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final episodeDetail = EpisodeDetailResponse.fromJson(jsonData);

      // Step 2: Ambil server ID dari episode
      final serverId = episodeDetail.data.server.qualities.first.serverList[1].serverId;
      final serverResponse = await http.get(Uri.parse('$baseUrl/server/$serverId'));

      if (serverResponse.statusCode != 200) {
        throw Exception('Failed to load server data: ${serverResponse.statusCode}');
      }

      final Map<String, dynamic> serverJson = jsonDecode(serverResponse.body);
      final embedUrl = serverJson["data"]["url"];


      // Step 3: Ekstrak URL video langsung dari embed page
      final videoUrl = await VideoExtractorService.extractVideoUrl(embedUrl);

      if (videoUrl != null) {
        episodeDetail.data.defaultStreamingUrl = videoUrl;
      }

      return episodeDetail;
    } catch (e) {
      rethrow;
    }
  }
}

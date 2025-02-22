import '../models/episode_detail_model.dart';
import '../services/episode_detail_service.dart';

class EpisodeDetailRepository {
  final EpisodeDetailService episodeDetailService;

  EpisodeDetailRepository({required this.episodeDetailService});

  Future<EpisodeDetailResponse> getEpisodeDetail(String episodeId) async {
    try {
      final data = await episodeDetailService.fetchEpisodeDetail(episodeId);
      return data;
    } catch (e) {
      print(e);
      throw Exception([e].toString());
    }
  }
}

import '../models/anime_detail_model.dart';
import '../services/anime_detail_service.dart';

class AnimeDetailRepository {
  final AnimeDetailService animeDetailService;

  AnimeDetailRepository({required this.animeDetailService});

  Future<AnimeDetailResponse> getAnimeDetail(String animeId) async {
    try {
      final data = await animeDetailService.fetchAnimeDetail(animeId);
      return data;
    } catch (e) {
      throw Exception("Terjadi kesalahan: $e");
    }
  }
}
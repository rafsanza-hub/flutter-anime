import 'package:flutter_anime/features/anime_status/models/ongoing_model.dart';
import 'package:flutter_anime/features/anime_status/services/ongoing_service.dart';

class OngoingRepository {
  final StatusService animeService;

  OngoingRepository({required this.animeService});

  // Method untuk mengambil data ongoing anime dengan pagination
  Future<StatusAnimeResponse> getOngoingAnime(int page) async {
    try {
      final data = await animeService.getOngoingAnime(page);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<StatusAnimeResponse> getCompletedAnime(int page) async {
    try {
      final data = await animeService.getCompletedAnime(page);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

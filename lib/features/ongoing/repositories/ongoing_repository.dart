import 'package:flutter_anime/features/ongoing/models/ongoing_model.dart';
import 'package:flutter_anime/features/ongoing/services/ongoing_service.dart';

class OngoingRepository {
  final OngoingService animeService;

  OngoingRepository({required this.animeService});

  // Method untuk mengambil data ongoing anime dengan pagination
  Future<OngoingAnimeResponse> getOngoingAnime(int page) async {
    try {
      final data = await animeService.getOngoingAnime(page);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
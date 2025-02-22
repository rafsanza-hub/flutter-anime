import 'package:flutter_anime/features/anime/models/anime_model.dart';
import 'package:flutter_anime/features/anime/services/anime_service.dart';

class AnimeRepository {
  final AnimeService animeService;

  AnimeRepository({required this.animeService});

  Future<List<Anime>> getAnimes() async {
    try {
      final data = await animeService.getAnimes();

      if (data.isEmpty) {
        throw Exception("Data Kosong");
      }
      
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

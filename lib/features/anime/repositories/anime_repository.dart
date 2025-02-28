import '../models/anime_model.dart';
import '../services/anime_service.dart';

class AnimeRepository {
  final AnimeService animeService;

  AnimeRepository({required this.animeService});

  Future<AnimeList> getAnimes() async {
    try {
      final data = await animeService.getAnimes();

      if (data.completed.isEmpty && data.ongoing.isEmpty) {
        throw Exception("Data Kosong");
      }

      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Anime>> searchAnimes(String query) async {
    try {
      final data = await animeService.searchAnimes(query);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

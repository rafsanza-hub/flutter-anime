import '../models/anime_genre_model.dart';
import '../services/anime_genre_service.dart';

class AnimeGenreRepository {
  final AnimeGenreService animeGenreService;

  AnimeGenreRepository({required this.animeGenreService});

  Future<AnimeGenreResponse> fetchAnimeList(String genreId,
      {int page = 1}) async {
    return await animeGenreService.fetchAnimeList(genreId, page: page);
  }
}

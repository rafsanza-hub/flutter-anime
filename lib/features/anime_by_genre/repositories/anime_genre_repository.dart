import 'package:flutter_anime/features/anime_by_genre/models/anime_genre_model.dart';
import 'package:flutter_anime/features/anime_by_genre/services/anime_genre_service.dart';

class AnimeGenreRepository {
  final AnimeGenreService animeGenreService;

  AnimeGenreRepository({required this.animeGenreService});

  Future<List<Anime>> fetchAnimeList(String genreId) async {
    return await animeGenreService.fetchAnimeList(genreId);
  }
}

import '../models/genre_model.dart';
import '../services/genre_service.dart';

class GenreRepository {
  final GenreService genreService;

  GenreRepository({required this.genreService});

  Future<List<Genre>> getGenres() async {
    return await genreService.fetchGenres();
  }
}

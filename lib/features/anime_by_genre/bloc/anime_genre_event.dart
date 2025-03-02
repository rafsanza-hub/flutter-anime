abstract class AnimeGenreEvent {}

class FetchAnimeGenreEvent extends AnimeGenreEvent {
  final String genreId;
  final int page;

  FetchAnimeGenreEvent({required this.genreId, this.page = 1});
}

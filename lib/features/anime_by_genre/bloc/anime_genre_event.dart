abstract class AnimeGenreEvent {}

class FetchAnimeGenreEvent extends AnimeGenreEvent {
  final String genreId;
  FetchAnimeGenreEvent({required this.genreId});
}
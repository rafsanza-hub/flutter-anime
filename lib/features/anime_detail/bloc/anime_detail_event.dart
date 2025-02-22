abstract class AnimeDetailEvent {}

class FetchAnimeDetail extends AnimeDetailEvent {
  final String animeId;

  FetchAnimeDetail(this.animeId);
}
abstract class EpisodeDetailEvent {}

class FetchEpisodeDetail extends EpisodeDetailEvent {
  final String episodeId;

  FetchEpisodeDetail(this.episodeId);
}
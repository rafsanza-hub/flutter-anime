import 'package:flutter_anime/features/episode_detail/models/episode_detail_model.dart';

abstract class EpisodeDetailState {}

class EpisodeDetailInitial extends EpisodeDetailState {}

class EpisodeDetailLoading extends EpisodeDetailState {}

class EpisodeDetailLoaded extends EpisodeDetailState {
  final EpisodeDetailResponse episodeDetail;

  EpisodeDetailLoaded(this.episodeDetail);
}

class EpisodeDetailError extends EpisodeDetailState {
  final String message;

  EpisodeDetailError(this.message);
}
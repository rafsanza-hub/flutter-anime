import 'package:flutter_anime/features/anime_detail/models/anime_detail_model.dart';

abstract class AnimeDetailState {}

class AnimeDetailInitial extends AnimeDetailState {}

class AnimeDetailLoading extends AnimeDetailState {}

class AnimeDetailLoaded extends AnimeDetailState {
  final AnimeDetailResponse animeDetail;

  AnimeDetailLoaded(this.animeDetail);
}

class AnimeDetailError extends AnimeDetailState {
  final String message;

  AnimeDetailError(this.message);
}
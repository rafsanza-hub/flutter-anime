import '../models/anime_genre_model.dart';

abstract class AnimeGenreState {}

class AnimeGenreInitial extends AnimeGenreState {}

class AnimeGenreLoading extends AnimeGenreState {}

class AnimeGenreLoaded extends AnimeGenreState {
  final AnimeGenreResponse response;

  AnimeGenreLoaded(this.response);
}

class AnimeGenreError extends AnimeGenreState {
  final String message;

  AnimeGenreError(this.message);
}

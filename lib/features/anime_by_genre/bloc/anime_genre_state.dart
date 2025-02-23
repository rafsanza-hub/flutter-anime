import 'package:flutter_anime/features/anime_by_genre/models/anime_genre_model.dart';

class AnimeGenreState {}

class AnimeGenreInitial extends AnimeGenreState{}

class AnimeGenreLoading extends AnimeGenreState {}

class AnimeGenreLoaded extends AnimeGenreState {
  final List<Anime> animeList;
  AnimeGenreLoaded(this.animeList);
}

class AnimeGenreError extends AnimeGenreState {
  final String message;
  AnimeGenreError(this.message);
}


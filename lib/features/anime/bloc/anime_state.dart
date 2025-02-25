part of 'anime_bloc.dart';

abstract class AnimeState {}

class AnimeInitial extends AnimeState {}

class AnimeLoadingState extends AnimeState {}

class AnimeLoadedState extends AnimeState {
  final AnimeList animeList;
  AnimeLoadedState({required this.animeList});
}

class AnimeErrorState extends AnimeState {
  final String message;
  AnimeErrorState({required this.message});
}

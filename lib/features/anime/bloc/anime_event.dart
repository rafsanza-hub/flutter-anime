part of 'anime_bloc.dart';

sealed class AnimeEvent {}

class FetchAnimeEvent extends AnimeEvent {}

class SearchAnimeEvent extends AnimeEvent {
  final String query;
  SearchAnimeEvent({required this.query});
}
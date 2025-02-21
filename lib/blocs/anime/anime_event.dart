part of 'anime_bloc.dart';

@immutable
sealed class AnimeEvent {}

class FetchAnimeEvent extends AnimeEvent {}
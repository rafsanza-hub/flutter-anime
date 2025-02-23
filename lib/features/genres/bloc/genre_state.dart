
import 'package:flutter_anime/features/genres/models/genre_model.dart';

abstract class GenreState {}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  final List<Genre> genres;
  GenreLoaded({required this.genres});
}

class GenreError extends GenreState {
  final String message;
  GenreError({required this.message});
}
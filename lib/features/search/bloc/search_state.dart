import 'package:flutter_anime/features/anime/models/anime_model.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
  final List<Anime> searchResults;

  const SearchLoaded(this.searchResults);
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);
}

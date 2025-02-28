import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_anime/features/anime/repositories/anime_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AnimeRepository animeRepository;

  SearchBloc({required this.animeRepository}) : super(const SearchInitial()) {
    on<SearchAnime>(_onSearchAnime);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchAnime(
    SearchAnime event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchLoading());
    try {
      final searchResults = await animeRepository.searchAnimes(event.query);
      emit(SearchLoaded(searchResults));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchInitial());
  }
}

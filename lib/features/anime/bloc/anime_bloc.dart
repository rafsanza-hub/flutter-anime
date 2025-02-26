// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_anime/features/anime/models/anime_model.dart';

import 'package:flutter_anime/features/anime/repositories/anime_repository.dart';

part 'anime_event.dart';
part 'anime_state.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final AnimeRepository animeRepository;
  AnimeBloc({
    required this.animeRepository,
  }) : super(AnimeInitial()) {
    on<FetchAnimeEvent>(_onFetchAnime);
    on<SearchAnimeEvent>(_onSearchAnime);
  }

  _onFetchAnime(FetchAnimeEvent event, Emitter<AnimeState> emit) async {
    emit(AnimeLoadingState());
    try {
      final animeList = await animeRepository.getAnimes();
      emit(AnimeLoadedState(animeList: animeList));
    } catch (e) {
      emit(AnimeErrorState(message: e.toString()));
    }
  }

   _onSearchAnime(SearchAnimeEvent event, Emitter<AnimeState> emit) async {
    emit(AnimeLoadingState());
    try {
      if (event.query.isEmpty) {
        final animeList = await animeRepository.getAnimes();
        emit(AnimeLoadedState(animeList: animeList));
      } else {
        final searchResults = await animeRepository.searchAnimes(event.query);
        emit(AnimeSearchLoadedState(searchResults: searchResults));
      }
    } catch (e) {
      emit(AnimeErrorState(message: e.toString()));
    }
  }
}

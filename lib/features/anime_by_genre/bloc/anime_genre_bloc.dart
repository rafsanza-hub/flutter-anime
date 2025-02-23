
import 'package:bloc/bloc.dart';
import 'package:flutter_anime/features/anime_by_genre/bloc/anime_genre_event.dart';
import 'package:flutter_anime/features/anime_by_genre/bloc/anime_genre_state.dart';
import 'package:flutter_anime/features/anime_by_genre/repositories/anime_genre_repository.dart';

class AnimeGenreBloc extends Bloc<AnimeGenreEvent, AnimeGenreState> {
  final AnimeGenreRepository animeGenreRepository;

  AnimeGenreBloc({required this.animeGenreRepository}) : super(AnimeGenreInitial()) {
    on<FetchAnimeGenreEvent>((event, emit) async {
      try {
        emit(AnimeGenreLoading());
        final animeList = await animeGenreRepository.fetchAnimeList(event.genreId);
        emit(AnimeGenreLoaded(animeList));
      } catch (e) {
        emit(AnimeGenreError(e.toString()));
      }
    });
  }
}

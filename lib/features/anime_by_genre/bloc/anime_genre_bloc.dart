import 'package:bloc/bloc.dart';
import 'anime_genre_event.dart';
import 'anime_genre_state.dart';
import '../repositories/anime_genre_repository.dart';
import '../models/anime_genre_model.dart';

class AnimeGenreBloc extends Bloc<AnimeGenreEvent, AnimeGenreState> {
  final AnimeGenreRepository animeGenreRepository;
  List<Anime> _currentAnimeList = [];

  AnimeGenreBloc({required this.animeGenreRepository})
      : super(AnimeGenreInitial()) {
    on<FetchAnimeGenreEvent>(_onFetchAnimeGenre);
  }

  void _onFetchAnimeGenre(
      FetchAnimeGenreEvent event, Emitter<AnimeGenreState> emit) async {
    try {
      if (event.page == 1) {
        emit(AnimeGenreLoading());
        final response = await animeGenreRepository
            .fetchAnimeList(event.genreId, page: event.page);
        _currentAnimeList = response.animeList;
        emit(AnimeGenreLoaded(response));
      } else {
        final response = await animeGenreRepository
            .fetchAnimeList(event.genreId, page: event.page);
        _currentAnimeList = [..._currentAnimeList, ...response.animeList];
        emit(AnimeGenreLoaded(
          AnimeGenreResponse(
            animeList: _currentAnimeList,
            pagination: response.pagination,
          ),
        ));
      }
    } catch (e) {
      emit(AnimeGenreError(e.toString()));
    }
  }
}

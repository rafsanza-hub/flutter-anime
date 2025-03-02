import 'package:bloc/bloc.dart';
import 'package:flutter_anime/features/anime/models/anime_model.dart';
import '../../models/ongoing_model.dart';
import '../../repositories/ongoing_repository.dart';

part 'completed_event.dart';
part 'completed_state.dart';

class CompletedBloc extends Bloc<CompletedEvent, CompletedState> {
  final OngoingRepository completedRepository;
  List<OngoingAnime> _currentAnimeList = [];

  CompletedBloc({required this.completedRepository})
      : super(CompletedInitial()) {
    on<FetchCompletedAnimeEvent>(_onFetchCompletedAnime);
  }

  void _onFetchCompletedAnime(
      FetchCompletedAnimeEvent event, Emitter<CompletedState> emit) async {
    try {
      if (event.page == 1) {
        emit(CompletedLoadingState());
        final completedAnimeResponse =
            await completedRepository.getCompletedAnime(event.page);
        _currentAnimeList = completedAnimeResponse.animeList;
        emit(CompletedLoadedState(
            completedAnimeResponse: completedAnimeResponse));
      } else {
        final completedAnimeResponse =
            await completedRepository.getCompletedAnime(event.page);
        _currentAnimeList = [
          ..._currentAnimeList,
          ...completedAnimeResponse.animeList
        ];
        emit(CompletedLoadedState(
          completedAnimeResponse: StatusAnimeResponse(
            animeList: _currentAnimeList,
            pagination: completedAnimeResponse.pagination,
          ),
        ));
      }
    } catch (e) {
      if (e.toString().contains('404')) {
        emit(CompletedLoadedState(
          completedAnimeResponse: StatusAnimeResponse(
            animeList: _currentAnimeList,
            pagination: Pagination(
              currentPage: event.page,
              hasPrevPage: event.page > 1,
              prevPage: event.page > 1 ? event.page - 1 : null,
              hasNextPage: false,
              nextPage: null,
              totalPages: event.page,
            ),
          ),
        ));
      } else {
        emit(CompletedErrorState(message: e.toString()));
      }
    }
  }
}

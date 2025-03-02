import 'package:bloc/bloc.dart';
import 'package:flutter_anime/features/anime/models/anime_model.dart';
import '../../models/ongoing_model.dart';
import '../../repositories/ongoing_repository.dart';

part 'ongoing_event.dart';
part 'ongoing_state.dart';

class OngoingBloc extends Bloc<OngoingEvent, OngoingState> {
  final OngoingRepository ongoingRepository;
  List<OngoingAnime> _currentAnimeList = [];

  OngoingBloc({required this.ongoingRepository}) : super(OngoingInitial()) {
    on<FetchOngoingAnimeEvent>(_onFetchOngoingAnime);
  }

  void _onFetchOngoingAnime(
      FetchOngoingAnimeEvent event, Emitter<OngoingState> emit) async {
    try {
      if (event.page == 1) {
        emit(OngoingLoadingState());
        final ongoingAnimeResponse =
            await ongoingRepository.getOngoingAnime(event.page);
        _currentAnimeList = ongoingAnimeResponse.animeList;
        emit(OngoingLoadedState(ongoingAnimeResponse: ongoingAnimeResponse));
      } else {
        final ongoingAnimeResponse =
            await ongoingRepository.getOngoingAnime(event.page);
        _currentAnimeList = [
          ..._currentAnimeList,
          ...ongoingAnimeResponse.animeList
        ];
        emit(OngoingLoadedState(
          ongoingAnimeResponse: StatusAnimeResponse(
            animeList: _currentAnimeList,
            pagination: ongoingAnimeResponse.pagination,
          ),
        ));
      }
    } catch (e) {
      emit(OngoingErrorState(message: e.toString()));
    }
  }
}

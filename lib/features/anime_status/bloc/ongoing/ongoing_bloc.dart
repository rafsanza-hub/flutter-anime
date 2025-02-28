import 'package:bloc/bloc.dart';
import '../../models/ongoing_model.dart';
import '../../repositories/ongoing_repository.dart';

part 'ongoing_event.dart';
part 'ongoing_state.dart';

class OngoingBloc extends Bloc<OngoingEvent, OngoingState> {
  final OngoingRepository ongoingRepository;
  OngoingBloc({required this.ongoingRepository}) : super(OngoingInitial()) {
    on<FetchOngoingAnimeEvent>(_onFetchOngoingAnime);
  }

  void _onFetchOngoingAnime(
      FetchOngoingAnimeEvent event, Emitter<OngoingState> emit) async {
    emit(OngoingLoadingState());
    try {
      final ongoingAnimeResponse =
          await ongoingRepository.getOngoingAnime(event.page);
      emit(OngoingLoadedState(ongoingAnimeResponse: ongoingAnimeResponse));
    } catch (e) {
      emit(OngoingErrorState(message: e.toString()));
    }
  }
}

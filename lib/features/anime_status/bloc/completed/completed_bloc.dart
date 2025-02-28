import 'package:bloc/bloc.dart';
import '../../models/ongoing_model.dart';
import '../../repositories/ongoing_repository.dart';

part 'completed_event.dart';
part 'completed_state.dart';

class CompletedBloc extends Bloc<CompletedEvent, CompletedState> {
  final OngoingRepository completedRepository;
  CompletedBloc({required this.completedRepository}) : super(CompletedInitial()) {
    on<FetchCompletedAnimeEvent>(_onFetchCompletedAnime);
  }

  void _onFetchCompletedAnime(
      FetchCompletedAnimeEvent event, Emitter<CompletedState> emit) async {
    emit(CompletedLoadingState());
    try {
      final completedAnimeResponse =
          await completedRepository.getCompletedAnime(event.page);
      emit(CompletedLoadedState(completedAnimeResponse: completedAnimeResponse));
    } catch (e) {
      emit(CompletedErrorState(message: e.toString()));
    }
  }
}

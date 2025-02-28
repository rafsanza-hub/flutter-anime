import 'episode_detail_bloc_event.dart';
import 'episode_detail_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/episode_detail_repository.dart';

class EpisodeDetailBloc extends Bloc<EpisodeDetailEvent, EpisodeDetailState> {
  final EpisodeDetailRepository episodeDetailRepository;

  EpisodeDetailBloc({required this.episodeDetailRepository})
      : super(EpisodeDetailInitial()) {
    on<FetchEpisodeDetail>((event, emit) async {
      emit(EpisodeDetailLoading());
      try {
        final episodeDetail =
            await episodeDetailRepository.getEpisodeDetail(event.episodeId);
        emit(EpisodeDetailLoaded(episodeDetail));
      } catch (e) {
        emit(EpisodeDetailError(e.toString()));
      }
    });
  }
}
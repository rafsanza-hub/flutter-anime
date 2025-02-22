import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/anime_detail_repository.dart';
import 'anime_detail_event.dart';
import 'anime_detail_state.dart';

class AnimeDetailBloc extends Bloc<AnimeDetailEvent, AnimeDetailState> {
  final AnimeDetailRepository animeDetailRepository;

  AnimeDetailBloc({required this.animeDetailRepository}) : super(AnimeDetailInitial()) {
    on<FetchAnimeDetail>((event, emit) async {
      emit(AnimeDetailLoading());
      try {
        final animeDetail = await animeDetailRepository.getAnimeDetail(event.animeId);
        emit(AnimeDetailLoaded(animeDetail));
      } catch (e) {
        emit(AnimeDetailError(e.toString()));
      }
    });
  }
}
import 'package:flutter_anime/features/genre/bloc/genre_event.dart';
import 'package:flutter_anime/features/genre/bloc/genre_state.dart';
import 'package:flutter_anime/features/genre/repositories/genre_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




// BLoC
class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GenreRepository genreRepository;

  GenreBloc({required this.genreRepository}) : super(GenreInitial()) {
    on<FetchGenres>((event, emit) async {
      emit(GenreLoading());
      try {
        final genres = await genreRepository.getGenres();
        emit(GenreLoaded(genres: genres));
      } catch (e) {
        emit(GenreError(message: e.toString()));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import '../models/history_model.dart';
import '../repositories/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository historyRepository;

  HistoryBloc({required this.historyRepository}) : super(HistoryInitial()) {
    on<AddHistoryEvent>(_onAddHistory);
    on<FetchHistoryEvent>(_onFetchHistory);
  }

  void _onAddHistory(AddHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      await historyRepository.addHistory(event.entry);
      final history = await historyRepository.getHistory();
      emit(HistoryLoaded(history: history));
    } catch (e) {
      emit(HistoryError(message: e.toString()));
    }
  }

  void _onFetchHistory(FetchHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final history = await historyRepository.getHistory();
      emit(HistoryLoaded(history: history));
    } catch (e) {
      emit(HistoryError(message: e.toString()));
    }
  }
}
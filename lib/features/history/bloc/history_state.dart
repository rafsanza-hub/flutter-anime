part of 'history_bloc.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryEntry> history;
  HistoryLoaded({required this.history});
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError({required this.message});
}
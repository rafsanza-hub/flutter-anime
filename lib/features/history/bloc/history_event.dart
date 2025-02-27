part of 'history_bloc.dart';

abstract class HistoryEvent {}

class AddHistoryEvent extends HistoryEvent {
  final HistoryEntry entry;
  AddHistoryEvent(this.entry);
}

class FetchHistoryEvent extends HistoryEvent {}

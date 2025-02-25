part of 'completed_bloc.dart';

abstract class CompletedEvent {}

class FetchCompletedAnimeEvent extends CompletedEvent {
  final int page;

  FetchCompletedAnimeEvent({required this.page});
}
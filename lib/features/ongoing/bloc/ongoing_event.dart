part of 'ongoing_bloc.dart';

abstract class OngoingEvent {}

class FetchOngoingAnimeEvent extends OngoingEvent {
  final int page;

  FetchOngoingAnimeEvent({required this.page});
}
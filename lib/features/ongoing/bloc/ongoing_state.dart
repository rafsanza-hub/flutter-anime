part of 'ongoing_bloc.dart';

abstract class OngoingState {}

class OngoingInitial extends OngoingState {}

class OngoingLoadingState extends OngoingState {}

class OngoingLoadedState extends OngoingState {
  final OngoingAnimeResponse ongoingAnimeResponse;

  OngoingLoadedState({required this.ongoingAnimeResponse});
}

class OngoingErrorState extends OngoingState {
  final String message;

  OngoingErrorState({required this.message});
}
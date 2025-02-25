part of 'completed_bloc.dart';

abstract class CompletedState {}

class CompletedInitial extends CompletedState {}

class CompletedLoadingState extends CompletedState {}

class CompletedLoadedState extends CompletedState {
  final StatusAnimeResponse completedAnimeResponse;

  CompletedLoadedState({required this.completedAnimeResponse});
}

class CompletedErrorState extends CompletedState {
  final String message;

  CompletedErrorState({required this.message});
}
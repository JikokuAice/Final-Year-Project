part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

// ignore: must_be_immutable
class FetchMapSucess extends NavigationState {
  MapEntity entity;
  FetchMapSucess({required this.entity});
}

class FetchMapFailure extends NavigationState {
  final bool failureOccured;
  const FetchMapFailure({required this.failureOccured});
}

class AddUserActivitySucess extends NavigationState {
  final String message;

  const AddUserActivitySucess({required this.message});
}

class AddUserActivityFailure extends NavigationState {
  final String message;
  const AddUserActivityFailure({required this.message});
}

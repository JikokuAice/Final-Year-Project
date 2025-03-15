part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetAllTrialSucess extends HomeState {
  final List<HikingCardItem> fetchedData;
  const GetAllTrialSucess({required this.fetchedData});
  @override
  List<Object> get props => [fetchedData];
}

class GetAllTrailEmpty extends HomeState {}

class GetAllTrialFailure extends HomeState {
  final String message;
  const GetAllTrialFailure({required this.message});
}

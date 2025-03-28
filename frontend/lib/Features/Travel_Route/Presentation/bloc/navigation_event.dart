part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class FetchSpecificMapEvent extends NavigationEvent {
  final int id;
  const FetchSpecificMapEvent({required this.id});
}

class AddUserActivityEvent extends NavigationEvent {
  final UseractivityEntity useractivityEntity;
  const AddUserActivityEvent({required this.useractivityEntity});
}

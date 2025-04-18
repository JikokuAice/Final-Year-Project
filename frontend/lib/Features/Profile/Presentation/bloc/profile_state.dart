part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class UserActivityFetchedSuccess extends ProfileState {
  final List<UserActivityEntity?> userActivity;
  const UserActivityFetchedSuccess({required this.userActivity});
}

class UserActivityFetchedFailure extends ProfileState {}

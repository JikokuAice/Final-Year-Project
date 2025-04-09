part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserActivityEvent extends ProfileEvent {
  final String token;
  const FetchUserActivityEvent({required this.token});
}

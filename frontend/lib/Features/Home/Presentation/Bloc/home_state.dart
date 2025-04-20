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

class GetTrailDetailSucess extends HomeState {
  TrailDetailEntity trailDetailEntity;
  GetTrailDetailSucess({required this.trailDetailEntity});
}

class GetTrailDetailFailure extends HomeState {
  final String failure;
  const GetTrailDetailFailure({required this.failure});
}

class GetTrailCommentSuccess extends HomeState {
  List<CommentEntity> trailCommentList;
  GetTrailCommentSuccess({required this.trailCommentList});
}

class GetTrailCommentFailure extends HomeState {
  final String message;
  const GetTrailCommentFailure({required this.message});
}

class DeleteUserCommentSucess extends HomeState {}

class DeleteUserCommentFailure extends HomeState {}

class AddUserCommentSucess extends HomeState {}

class AddUserCommentFailure extends HomeState {}

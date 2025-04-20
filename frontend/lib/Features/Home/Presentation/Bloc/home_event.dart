part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAllTrailsEvent extends HomeEvent {}

class GetTrailDetailEvent extends HomeEvent {
  final int trailId;
  const GetTrailDetailEvent({required this.trailId});
}

class GetTrailCommentEvent extends HomeEvent {
  final int trailId;
  const GetTrailCommentEvent({required this.trailId});
}

class DeleteUserCommentEvent extends HomeEvent {
  final int userId;
  final int commentId;

  const DeleteUserCommentEvent({required this.commentId, required this.userId});
}

// ignore: must_be_immutable
class AddUserCommentEvent extends HomeEvent {
  AddCommentEntity entity;
  AddUserCommentEvent({required this.entity});
}

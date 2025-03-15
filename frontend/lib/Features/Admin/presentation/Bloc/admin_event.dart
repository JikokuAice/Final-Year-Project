part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class FetchElevation extends AdminEvent {
  final String longitude;
  final String latitude;
  const FetchElevation({required this.latitude, required this.longitude});
}

class CreateTrailWithMapEvent extends AdminEvent {
  final CreateTrailWithMap createTrailWithMapEntity;
  const CreateTrailWithMapEvent({required this.createTrailWithMapEntity});
}

class DeleteTrailWithMapEvent extends AdminEvent {
  final int id;
  const DeleteTrailWithMapEvent({required this.id});
}

class GetSepecificTrailEvent extends AdminEvent {
  final int id;
  const GetSepecificTrailEvent({required this.id});
}

// ignore: must_be_immutable
class UpdateTrailWithMapEvent extends AdminEvent {
  UpdateTrailWithMapEntity? entity;
  UpdateTrailWithMapEvent({required this.entity});
}

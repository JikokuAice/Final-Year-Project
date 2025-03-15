part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class ElevationFetchedSuccess extends AdminState {
  final String elevation;
  const ElevationFetchedSuccess({required this.elevation});
  @override
  List<Object> get props => [elevation];
}

class ElevationFetchedError extends AdminState {}

class CreateTrailWithMapSucess extends AdminState {
  final String message;
  const CreateTrailWithMapSucess({required this.message});
}

class CreateTrailWithMapError extends AdminState {
  final String message;
  const CreateTrailWithMapError({required this.message});
}

class DeleteTrailWithMapSuccess extends AdminState {
  final String message;
  const DeleteTrailWithMapSuccess({required this.message});
}

class DeleteTrailWithMapFailure extends AdminState {
  final String message;
  const DeleteTrailWithMapFailure({required this.message});
}

// ignore: must_be_immutable
class GetSepecificTrailSuccess extends AdminState {
  GetTrialWithMapEntity? entity = GetTrialWithMapEntity();
  GetSepecificTrailSuccess({required this.entity});
}

class GetSepecificTrailFailure extends AdminState {
  final String message;
  const GetSepecificTrailFailure({required this.message});
}

class UpdateTrailWithMapSuccess extends AdminState {
  final String msg;
  const UpdateTrailWithMapSuccess({required this.msg});
}

class UpdateTrailWithMapFailure extends AdminState {
  final String msg;
  const UpdateTrailWithMapFailure({required this.msg});
}

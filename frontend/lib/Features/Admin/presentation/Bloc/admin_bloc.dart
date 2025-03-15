import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/Features/Admin/Domain/Usecase/create_trail_with_map_usecase.dart';
import 'package:frontend/Features/Admin/Domain/Usecase/delete_trail_with_map_usecase.dart';
import 'package:frontend/Features/Admin/Domain/Usecase/get_sepecific_trail_usecase.dart';
import 'package:frontend/Features/Admin/Domain/Usecase/retrive_elevation_usecase.dart';
import 'package:frontend/Features/Admin/Domain/Usecase/update_trail_with_map_usecase.dart';
import 'package:frontend/Features/Admin/Domain/entity/create_trail_with_map.dart';
import 'package:frontend/Features/Admin/Domain/entity/getTrailWithMapEntity.dart';
import 'package:frontend/Features/Admin/Domain/entity/update_trail_with_map_entity.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final RetriveElevationUsecase retriveElevationUsecase;
  final CreateTrailWithMapUsecase createTrailWithMapUsecase;
  final DeleteTrailWithMapUsecase deleteTrailWithMapUsecase;
  final GetSepecificTrailUsecase getSepecificTrailUsecase;
  final UpdateTrailWithMapUsecase updateTrailWithMapUsecase;

  AdminBloc(
      {required this.retriveElevationUsecase,
      required this.deleteTrailWithMapUsecase,
      required this.createTrailWithMapUsecase,
      required this.getSepecificTrailUsecase,
      required this.updateTrailWithMapUsecase})
      : super(AdminInitial()) {
    on<FetchElevation>((event, emit) async {
      try {
        var result =
            await retriveElevationUsecase.call(event.latitude, event.longitude);
        if (result!.isEmpty) {
          emit(ElevationFetchedError());
        }
        emit(ElevationFetchedSuccess(elevation: result));
      } catch (e) {
        emit(ElevationFetchedError());
      }
    });

    on<CreateTrailWithMapEvent>((event, emit) async {
      try {
        var result = await createTrailWithMapUsecase
            .call(event.createTrailWithMapEntity);

        if (result == null || result != "200") {
          emit(const CreateTrailWithMapError(message: "unexpected error"));
        }
        emit(CreateTrailWithMapSucess(message: result.toString()));
      } catch (e) {
        emit(CreateTrailWithMapError(message: e.toString()));
      }
    });

    on<DeleteTrailWithMapEvent>((event, emit) async {
      try {
        var result = await deleteTrailWithMapUsecase.call(event.id);
        if (result == null || result != "200") {
          emit(const DeleteTrailWithMapFailure(message: "unexpected error"));
        }
        emit(DeleteTrailWithMapSuccess(message: result.toString()));
      } catch (e) {
        emit(DeleteTrailWithMapFailure(message: e.toString()));
      }
    });

    on<GetSepecificTrailEvent>((event, emit) async {
      try {
        emit(AdminInitial());
        var result = await getSepecificTrailUsecase.call(event.id);
        emit(GetSepecificTrailSuccess(entity: result));
      } catch (e) {
        emit(DeleteTrailWithMapFailure(message: e.toString()));
      }
    });

    on<UpdateTrailWithMapEvent>((event, emit) async {
      try {
        var result = await updateTrailWithMapUsecase.call(event.entity!);
        return emit(
          UpdateTrailWithMapSuccess(
            msg: result.toString(),
          ),
        );
      } catch (e) {
        emit(const UpdateTrailWithMapFailure(msg: "Update Failed"));
      }
    });
  }
}

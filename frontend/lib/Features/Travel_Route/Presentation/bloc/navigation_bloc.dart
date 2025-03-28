import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/Features/Travel_Route/Domain/Entity/Map_Entity.dart';
import 'package:frontend/Features/Travel_Route/Domain/Entity/UserActivity_Entity.dart';
import 'package:frontend/Features/Travel_Route/Domain/Use_Case/Add_User_Activity_UseCase.dart';
import 'package:frontend/Features/Travel_Route/Domain/Use_Case/Fetch_Map_Usecase.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  FetchMapUsecase fetchMapUsecase;
  AddUserActivityUsecase userActivityUsecase;
  NavigationBloc(
      {required this.fetchMapUsecase, required this.userActivityUsecase})
      : super(NavigationInitial()) {
    on<FetchSpecificMapEvent>((event, emit) async {
      try {
        var result = await fetchMapUsecase.call(event.id);
        emit(const FetchMapFailure(failureOccured: false));
        emit(FetchMapSucess(entity: result!));
      } catch (e) {
        emit(const FetchMapFailure(failureOccured: true));
      }
    });

    on<AddUserActivityEvent>((event, emit) async {
      try {
        var result = await userActivityUsecase.call(event.useractivityEntity);
        emit(const AddUserActivitySucess(message: "sucessfully Added"));
        if (!result) {
          emit(const AddUserActivityFailure(
              message: "error occured please try again"));
        }
      } catch (e) {
        emit(const AddUserActivityFailure(message: "error occured"));
      }
    });
  }
}

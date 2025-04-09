import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/Features/Profile/Domain/use%20case/Get_Useractivity_Usecase.dart';

import '../../Domain/Entity/user_activity_entity.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetUseractivityUsecase getUseractivityUsecase;

  ProfileBloc({required this.getUseractivityUsecase})
      : super(ProfileInitial()) {
    on<FetchUserActivityEvent>(
      (event, emit) async {
        try {
          var result = await getUseractivityUsecase.call(event.token);
          if (result.isEmpty) {
            emit(UserActivityFetchedFailure());
          }
          emit(UserActivityFetchedSuccess(userActivity: result));
        } catch (e) {
          emit(UserActivityFetchedFailure());
        }
      },
    );
  }
}

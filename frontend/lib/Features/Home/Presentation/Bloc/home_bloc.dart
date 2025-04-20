import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/Features/Home/Domain/Entity/Hiking_Card_Item.dart';
import 'package:frontend/Features/Home/Domain/Entity/add_comment_entity.dart';
import 'package:frontend/Features/Home/Domain/Entity/comment_entity.dart';
import 'package:frontend/Features/Home/Domain/Entity/trail_detail_entity.dart';
import 'package:frontend/Features/Home/Domain/Usecase/add_user_comment_usecase.dart';
import 'package:frontend/Features/Home/Domain/Usecase/delete_user_comment_usecase.dart';
import 'package:frontend/Features/Home/Domain/Usecase/get_hiking_item_usecase.dart';
import 'package:frontend/Features/Home/Domain/Usecase/get_trail_comment.dart';
import 'package:frontend/Features/Home/Domain/Usecase/get_trail_detail_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AddUserCommentUsecase addUserCommentUsecase;
  final GetHikingItemUsecase getHikingItemUsecase;
  final GetTrailDetailUsecase getTrailDetailUsecase;
  final GetTrailCommentUsecase getTrailCommentUsecase;
  final DeleteUserCommentUsecase deleteUserCommentUsecase;

  HomeBloc(
      {required this.getHikingItemUsecase,
      required this.getTrailDetailUsecase,
      required this.getTrailCommentUsecase,
      required this.deleteUserCommentUsecase,
      required this.addUserCommentUsecase})
      : super(HomeInitial()) {
    on<GetAllTrailsEvent>((event, emit) async {
      try {
        var result = await getHikingItemUsecase.call();
        if (result == null || result.isEmpty) {
          emit(GetAllTrailEmpty());
        } else {
          emit(GetAllTrialSucess(fetchedData: result));
        }
      } catch (e) {
        emit(
          GetAllTrialFailure(
            message: e.toString(),
          ),
        );
      }
    });

    on<GetTrailDetailEvent>((event, emit) async {
      try {
        var result = await getTrailDetailUsecase.call(event.trailId);

        emit(GetTrailDetailSucess(trailDetailEntity: result));
      } catch (e) {
        emit(
          GetTrailDetailFailure(failure: e.toString()),
        );
      }
    });

    on<GetTrailCommentEvent>((event, emit) async {
      try {
        var result = await getTrailCommentUsecase.call(event.trailId);
        if (result!.isEmpty) {
          emit(const GetTrailCommentFailure(message: "error"));
        } else {
          emit(GetTrailCommentSuccess(trailCommentList: result!));
        }
      } catch (e) {
        emit(GetTrailCommentFailure(message: e.toString()));
      }
    });

    on<DeleteUserCommentEvent>((event, emit) async {
      try {
        var result =
            await deleteUserCommentUsecase.call(event.commentId, event.userId);
        if (result) {
          emit(DeleteUserCommentSucess());
        } else {
          emit(DeleteUserCommentFailure());
        }
      } catch (e) {
        emit(DeleteUserCommentFailure());
      }
    });

    on<AddUserCommentEvent>((event, emit) async {
      try {
        var result = await addUserCommentUsecase.call(event.entity);
        if (result) {
          emit(AddUserCommentSucess());
        } else {
          emit(AddUserCommentFailure());
        }
      } catch (e) {
        emit(AddUserCommentFailure());
      }
    });
  }
}

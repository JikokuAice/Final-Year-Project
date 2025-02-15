import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/Features/Home/Domain/Entity/Hiking_Card_Item.dart';
import 'package:frontend/Features/Home/Domain/Usecase/get_hiking_item_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHikingItemUsecase getHikingItemUsecase;
  HomeBloc({required this.getHikingItemUsecase}) : super(HomeInitial()) {
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
  }
}

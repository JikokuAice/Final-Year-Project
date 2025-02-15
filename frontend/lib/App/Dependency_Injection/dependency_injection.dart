import 'package:dio/dio.dart';
import 'package:frontend/Core/Network/dio_client.dart';
import 'package:frontend/Features/Authentication/Data/Repositories/auth_repo_Imp.dart';
import 'package:frontend/Features/Authentication/Data/data_source/auth_remote_data_source.dart';
import 'package:frontend/Features/Authentication/Domain/Repository/auth_repo.dart';
import 'package:frontend/Features/Authentication/Domain/UseCase/login_usecase.dart';
import 'package:frontend/Features/Authentication/Domain/UseCase/register_usecase.dart';
import 'package:frontend/Features/Authentication/Presentation/Bloc/auth_bloc.dart';
import 'package:frontend/Features/Home/Data/Data_Source/remote_data_source.dart';
import 'package:frontend/Features/Home/Data/Repositories/home_repo_imp.dart';
import 'package:frontend/Features/Home/Domain/Repository/home_repo.dart';
import 'package:frontend/Features/Home/Domain/Usecase/get_hiking_item_usecase.dart';
import 'package:frontend/Features/Home/Presentation/Bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final sl = GetIt.instance;

void init() {
//dio config
  var dio = createDio(baseUrl: "https://192.168.100.7:5001");
  sl.registerLazySingleton<Dio>(() => dio);

//Logger Config
  var logger = Logger();
  sl.registerLazySingleton<Logger>(() => logger);

//Data source Config
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(sl<Dio>(), sl<Logger>()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(sl<Dio>(), sl<Logger>()));

//Repositories
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(authRemoteDataSource: sl<AuthRemoteDataSource>()));
  sl.registerLazySingleton<HomeRepo>(
      () => HomeRepoImp(remoteDataSource: sl<RemoteDataSource>()));

//Usecases
  sl.registerLazySingleton(() => RegisterUsecase(authRepo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => LoginUsecase(authRepo: sl<AuthRepo>()));
  sl.registerLazySingleton(
      () => GetHikingItemUsecase(homeRepo: sl<HomeRepo>()));

//bloc
  sl.registerFactory(
    () => AuthBloc(
      registerUsecase: sl<RegisterUsecase>(),
      loginUsecase: sl<LoginUsecase>(),
    ),
  );

  sl.registerFactory(
      () => HomeBloc(getHikingItemUsecase: sl<GetHikingItemUsecase>()));
}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:story_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:story_app/data/repositories/auth_repository_impl.dart';
import 'package:story_app/domain/entities/auth/auth_preferences.dart';
import 'package:story_app/domain/entities/auth/login/login_request/login_request.dart';
import 'package:story_app/domain/entities/auth/register/register_request/register_request.dart';
import 'package:story_app/domain/repositories/auth_repository.dart';
import 'package:story_app/domain/usecase/do_register.dart';
import 'package:story_app/domain/usecase/do_login.dart' as t;
import 'package:story_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:story_app/presentation/auth/register/bloc/register_bloc.dart';

import '../../presentation/auth/login/bloc/login_bloc.dart';

final locator = GetIt.instance;

void init() {
  // Data Source
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: locator()));

  // Dio
  locator.registerLazySingleton(() => Dio());

  // Repository
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: locator()));

  // Use Case
  locator.registerLazySingleton(() => DoRegister(locator()));
  locator.registerLazySingleton(() => t.DoLogin(locator()));

  // Bloc
  locator.registerSingleton(RegisterBloc(locator<DoRegister>()));
  locator.registerSingleton(LoginBloc(locator<t.DoLogin>()));
  locator.registerSingleton( AuthBloc());

  locator.registerFactory(() => AuthPreferences());

  locator.registerFactory<RegisterRequest>(() => RegisterRequest());
  locator.registerFactory<LoginRequest>(() => LoginRequest());
}

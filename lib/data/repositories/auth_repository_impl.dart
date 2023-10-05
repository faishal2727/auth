import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:story_app/common/exception.dart';
import 'package:story_app/common/failure.dart';
import 'package:story_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:story_app/domain/entities/auth/login/login_request/login_request.dart';
import 'package:story_app/domain/entities/auth/login/login_response/login_response.dart';
import 'package:story_app/domain/entities/auth/register/register_request/register_request.dart';
import 'package:story_app/domain/entities/auth/register/register_response/register_response.dart';
import 'package:story_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, RegisterResponse>> doRegister(
      RegisterRequest register) async {
    try {
      final result = await remoteDataSource.doRegister(register);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect'));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> doLogin(LoginRequest login) async {
    try {
      final result = await remoteDataSource.doLogin(login);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect'));
    }
  }
}

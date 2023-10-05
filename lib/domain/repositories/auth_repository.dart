import 'package:story_app/common/failure.dart';
import 'package:story_app/domain/entities/auth/login/login_request/login_request.dart';
import 'package:story_app/domain/entities/auth/login/login_response/login_response.dart';
import 'package:story_app/domain/entities/auth/register/register_request/register_request.dart';
import 'package:story_app/domain/entities/auth/register/register_response/register_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterResponse>> doRegister(
      RegisterRequest register);
  Future<Either<Failure, LoginResponse>> doLogin(LoginRequest login);
}

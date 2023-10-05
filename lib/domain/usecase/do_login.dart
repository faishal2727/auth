import 'package:dartz/dartz.dart';
import 'package:story_app/common/failure.dart';
import 'package:story_app/domain/entities/auth/login/login_request/login_request.dart';
import 'package:story_app/domain/entities/auth/login/login_response/login_response.dart';
import 'package:story_app/domain/repositories/auth_repository.dart';

class DoLogin {
  final AuthRepository repository;
  DoLogin(this.repository);

  Future<Either<Failure, LoginResponse>> execute(LoginRequest login) {
    return repository.doLogin(login);
  }
}

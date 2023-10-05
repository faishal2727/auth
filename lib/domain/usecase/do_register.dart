import 'package:dartz/dartz.dart';
import 'package:story_app/common/failure.dart';
import 'package:story_app/domain/entities/auth/register/register_request/register_request.dart';
import 'package:story_app/domain/entities/auth/register/register_response/register_response.dart';
import 'package:story_app/domain/repositories/auth_repository.dart';

class DoRegister {
  final AuthRepository repository;
  DoRegister(this.repository);

  Future<Either<Failure, RegisterResponse>> execute(RegisterRequest register) {
    return repository.doRegister(register);
  }
}

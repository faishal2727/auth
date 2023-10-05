part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.loading() = Loading;
  const factory RegisterState.succes(RegisterResponse response) = Sucsess;
  const factory RegisterState.error(String error) = Error;
}

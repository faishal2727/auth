import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/di/injection.dart';
import 'package:story_app/domain/entities/auth/auth_preferences.dart';
import 'package:story_app/domain/entities/auth/login/login_request/login_request.dart';
import 'package:story_app/domain/entities/auth/login/login_response/login_response.dart';
import '../../../../domain/usecase/do_login.dart' as t;

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final t.DoLogin doLogin;
  LoginBloc(this.doLogin) : super(const _Initial()) {
    on<DoLogin>(_onDoLogin);
  }

  Future<void> _onDoLogin(DoLogin event, Emitter<LoginState> emit) async {
    emit(const LoginState.loading());
    try {
      final data = await doLogin.execute(event.login);
      emit(
        data.fold(
          (error) => Error(error.message),
          (data) {
            debugPrint("tocken ${data.loginResult!.token!}");
            locator.get<AuthPreferences>().setToken(data.loginResult!.token!);
            return Success(data);
          },
        ),
      );
    } catch (e) {
      emit(const LoginState.error('gagal login'));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/di/injection.dart';
import 'package:story_app/domain/entities/auth/auth_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const _Initial()) {
    on<CheckLogin>(_onCheckLogin);
  }

  Future<void> _onCheckLogin(CheckLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
        isLogin: await locator.get<AuthPreferences>().isLogin()));
  }
}

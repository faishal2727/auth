import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/domain/entities/auth/register/register_request/register_request.dart';
import 'package:story_app/domain/entities/auth/register/register_response/register_response.dart';

import '../../../../domain/usecase/do_register.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final DoRegister doRegister;
  RegisterBloc(this.doRegister) : super(const _Initial()) {
    on<DooRegister>(_onDoRegister);
  }

  Future<void> _onDoRegister(
      DooRegister event, Emitter<RegisterState> emit) async {
    emit(const RegisterState.loading());
    try {
      final data = await doRegister.execute(event.register);
      debugPrint("mm $data");

      emit(data.fold((l) => Error(l.message), (data) => Sucsess(data)));
    } catch (e) {
      debugPrint("Pesan: ${e.toString()}");
      emit(const RegisterState.error("gagal nih"));
    }
  }
}

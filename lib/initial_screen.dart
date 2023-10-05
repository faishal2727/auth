import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:story_app/presentation/auth/login/screen/login_screen.dart';
import 'package:story_app/presentation/home/home_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state.isLogin) {
        return HomeScreen();
      }
      return LoginScreen();
    });
  }
}

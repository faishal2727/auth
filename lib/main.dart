import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/di/injection.dart' as di;
import 'package:story_app/initial_screen.dart';
import 'package:story_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:story_app/presentation/auth/login/bloc/login_bloc.dart';
import 'package:story_app/presentation/auth/login/screen/login_screen.dart';
import 'package:story_app/presentation/auth/register/bloc/register_bloc.dart';
import 'package:story_app/presentation/auth/register/screen/register_screen.dart';

void main() async {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<RegisterBloc>()
            ..add(RegisterEvent.doRegister(di.locator())),
        ),
        BlocProvider(
          create: (context) =>
              di.locator<LoginBloc>()..add(LoginEvent.doLogin(di.locator())),
        ),
        BlocProvider(
          create: (context) =>
              di.locator<AuthBloc>()..add(AuthEvent.checkLogin()),
        ),
      ],
      child: MaterialApp(
        title: 'aplikasi',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const InitialScreen(),
      ),
    );
  }
}

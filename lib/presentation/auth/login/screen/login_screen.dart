import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/domain/entities/auth/login/login_request/login_request.dart';
import 'package:story_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:story_app/presentation/auth/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final authBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Masukan email',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              hintText: 'Masukan password',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if(state is Success){
                context.read<AuthBloc>().add(CheckLogin());
              }
            },
            builder: (context, state) {
              if (state is Loading) {
                return const CircularProgressIndicator();
              } else if (state is Error) {
                return Column(
                  children: [
                    Text('Error: ${state.message}'),
                    ElevatedButton(
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;
                        final loginEvent = LoginEvent.doLogin(
                          LoginRequest(email: email, password: password),
                        );
                        authBloc.add(loginEvent);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                );
              } else if (state is Success) {

                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (_) => const HomeScreen(),
                //   ),
                // );
                return Container();
              } else {
                return ElevatedButton(
                  onPressed: () {
                    final email = emailController.text;
                    final password = passwordController.text;
                    final loginEvent = LoginEvent.doLogin(
                      LoginRequest(email: email, password: password),
                    );
                    authBloc.add(loginEvent);
                  },
                  child: const Text('Login'),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

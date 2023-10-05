import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:story_app/domain/entities/auth/register/register_request/register_request.dart';
import 'package:story_app/presentation/auth/login/screen/login_screen.dart';
import 'package:story_app/presentation/auth/register/bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final authBloc = BlocProvider.of<RegisterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: 'Masukan Nama',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber))),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: 'Masukan email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber))),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: 'Masukan password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber))),
                ),
                const SizedBox(
                  height: 14,
                ),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      return const CircularProgressIndicator();
                    } else if (state is Error) {
                      return Column(
                        children: [
                          Text('Error: ${state.error}'),
                          ElevatedButton(
                            onPressed: () {
                              final name = nameController.text;
                              final email = emailController.text;
                              final password = passwordController.text;
                              final loginEvent = RegisterEvent.doRegister(
                                RegisterRequest(
                                    name: name,
                                    email: email,
                                    password: password),
                              );
                              authBloc.add(loginEvent);
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      );
                    } else if (state is Sucsess) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                      return Container();
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          final name = nameController.text;
                          final email = emailController.text;
                          final password = passwordController.text;

                          final registerEvent = RegisterEvent.doRegister(
                            RegisterRequest(
                              name: name,
                              email: email,
                              password: password,
                            ),
                          );
                          authBloc.add(registerEvent);
                        },
                        child: const Text('Daftar'),
                      );
                    }
                  },
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text("Sudah Punya Akun ? Login di sini"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

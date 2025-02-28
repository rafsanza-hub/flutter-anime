// features/auth/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_anime/features/main/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Login dengan Google'),
                onPressed: () {
                  context.read<AuthBloc>().add(SignInWithGoogleEvent());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
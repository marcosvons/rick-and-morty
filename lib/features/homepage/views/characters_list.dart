import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';

import 'package:rick_and_morty_challenge/features/login/views/login_page.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CharactersList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          unauthenticated: () => Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const LoginPage(),
            ),
          ),
        );
      },
      child: Container(
        color: Colors.pink,
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEvent.logout());
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}

import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/core/injector/injector.dart';
import 'package:rick_and_morty_challenge/features/login/cubit/login_cubit.dart';
import 'package:rick_and_morty_challenge/features/login/widgets/login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(authRepository: getIt<IAuthRepository>()),
      child: const LoginBody(),
    );
  }
}

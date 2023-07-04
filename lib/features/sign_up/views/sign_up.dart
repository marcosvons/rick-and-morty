import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/core/constants/dimens.dart';
import 'package:rick_and_morty_challenge/core/injector/injector.dart';
import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';
import 'package:rick_and_morty_challenge/features/homepage/views/characters_list.dart';
import 'package:rick_and_morty_challenge/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:rick_and_morty_challenge/features/sign_up/widgets/sign_up_form.dart';
import 'package:rick_and_morty_challenge/l10n/l10n.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: () =>
              Navigator.of(context).push<void>(CharactersList.route()),
        );
      },
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(Spacers.medium),
          child: BlocProvider(
            create: (context) =>
                SignUpCubit(authRepository: getIt<IAuthRepository>()),
            child: const SignUpForm(),
          ),
        ),
      ),
    );
  }
}

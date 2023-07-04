import 'package:dio/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rick_and_morty_challenge/core/constants/dimens.dart';
import 'package:rick_and_morty_challenge/core/constants/string_constants.dart';
import 'package:rick_and_morty_challenge/core/theme/app_theme.dart';
import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';
import 'package:rick_and_morty_challenge/features/homepage/views/characters_list.dart';
import 'package:rick_and_morty_challenge/features/login/cubit/login_cubit.dart';
import 'package:rick_and_morty_challenge/features/sign_up/views/sign_up.dart';
import 'package:rick_and_morty_challenge/l10n/l10n.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.whenOrNull(
              authenticated: () => Navigator.of(context).push<void>(
                CharactersList.route(),
              ),
            );
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == FormzStatus.submissionFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                SnackBar(
                  content: Text(
                    state.failure == const Failure.userNotFoundError()
                        ? l10n.userNotFoundError
                        : state.failure ==
                                const Failure.invalidCredentialsError()
                            ? l10n.invalidCredentialsError
                            : l10n.unknownError,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(Spacers.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(AssetConstants.rickAndMortyLogo),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Spacers.small),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: l10n.email,
                          ),
                          onChanged: (value) =>
                              context.read<LoginCubit>().emailChanged(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(Spacers.small),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: l10n.password,
                          ),
                          obscureText: true,
                          onChanged: (value) =>
                              context.read<LoginCubit>().passwordChanged(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Spacers.large,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (state.password.value != '' &&
                                    state.email.value != '')
                                ? theme.primaryColor
                                : Palette.disabledButtonColor,
                            fixedSize: Size(
                              MediaQuery.of(context).size.width *
                                  Multipliers.x35,
                              MediaQuery.of(context).size.height *
                                  Multipliers.x05,
                            ),
                          ),
                          child: Text(
                            l10n.login,
                            style: TextStyle(
                              color: (state.password.value != '' &&
                                      state.email.value != '')
                                  ? theme.textTheme.button?.color
                                  : theme.disabledColor,
                            ),
                          ),
                          onPressed: () {
                            if (state.password.value != '' &&
                                state.email.value != '') {
                              context.read<LoginCubit>().loginSubmission();
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(l10n.createAccount),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push<void>(
                              SignUpPage.route(),
                            ),
                            child: Text(
                              l10n.signUp,
                              style: const TextStyle(
                                color: Color(0xFFa6eee6),
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rick_and_morty_challenge/core/constants/dimens.dart';
import 'package:rick_and_morty_challenge/core/constants/string_constants.dart';
import 'package:rick_and_morty_challenge/core/theme/app_theme.dart';
import 'package:rick_and_morty_challenge/features/login/views/login.dart';
import 'package:rick_and_morty_challenge/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:rick_and_morty_challenge/l10n/l10n.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});
  static const int errorMaxLines = 3;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(
                state.failure == const AuthFailure.emailAlreadyExistsError()
                    ? l10n.emailAlreadyExistsError
                    : l10n.unknownError,
                style: TextStyle(color: theme.errorColor),
              ),
            ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(AssetConstants.rickAndMortyLogo),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Spacers.small),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: l10n.email,
                        errorText: !state.email.pure
                            ? state.email.error?.when(
                                empty: () => l10n.emptyEmail,
                                invalid: () => l10n.invalidEmail,
                              )
                            : null,
                      ),
                      onChanged: (value) =>
                          context.read<SignUpCubit>().emailChanged(value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Spacers.small),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: l10n.password,
                        errorText: !state.password.pure
                            ? state.password.error?.when(
                                empty: () => l10n.emptyPassword,
                                invalid: () => l10n.invalidPassword,
                              )
                            : null,
                        errorMaxLines: errorMaxLines,
                      ),
                      obscureText: true,
                      onChanged: (value) =>
                          context.read<SignUpCubit>().passwordChanged(value),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: Spacers.large),
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.status == FormzStatus.valid) {
                          context.read<SignUpCubit>().signUpSubmission();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.status == FormzStatus.valid
                            ? theme.primaryColor
                            : Palette.disabledButtonColor,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * Multipliers.x35,
                          MediaQuery.of(context).size.height * Multipliers.x05,
                        ),
                      ),
                      child: Text(
                        l10n.signUp,
                        style: TextStyle(
                          color: state.status == FormzStatus.valid
                              ? theme.textTheme.button?.color
                              : theme.disabledColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.alreadyHaveAnAccount),
                      GestureDetector(
                        child: Text(
                          l10n.logIn,
                          style: const TextStyle(
                            color: Color(0xFFa6eee6),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push<void>(LoginView.route());
                        },
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

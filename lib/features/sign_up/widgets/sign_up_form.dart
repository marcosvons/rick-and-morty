import 'package:dio/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rick_and_morty_challenge/core/constants/string_constants.dart';
import 'package:rick_and_morty_challenge/features/login/views/login_page.dart';
import 'package:rick_and_morty_challenge/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:rick_and_morty_challenge/l10n/l10n.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(
                state.failure == const Failure.emailAlreadyExistsError()
                    ? 'This email is already in use'
                    : 'Something went wrong',
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(ImageConstants.rickAndMortyLogo),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
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
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: l10n.password,
                        errorText: !state.password.pure
                            ? state.password.error?.when(
                                empty: () => l10n.emptyPassword,
                                invalid: () => l10n.invalidPassword,
                              )
                            : null,
                        errorMaxLines: 3,
                      ),
                      obscureText: true,
                      onChanged: (value) =>
                          context.read<SignUpCubit>().passwordChanged(value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.status == FormzStatus.valid) {
                          context.read<SignUpCubit>().signUpSubmission();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.status == FormzStatus.valid
                            ? const Color(0xFF5CAD4A)
                            : Colors.transparent,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.3,
                          MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: state.status == FormzStatus.valid
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      GestureDetector(
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Color(0xFFa6eee6),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push<void>(LoginPage.route());
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

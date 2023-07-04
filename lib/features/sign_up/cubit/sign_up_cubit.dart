import 'dart:async';

import 'package:auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/lib.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_challenge/core/validators/email.dart';
import 'package:rick_and_morty_challenge/core/validators/password.dart';

part 'sign_up_cubit.freezed.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required IAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignUpState());

  final IAuthRepository _authRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  FutureOr<void> signUpSubmission() async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final email = state.email;
      final password = state.password;

      final successOrFailure =
          await _authRepository.registerWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      successOrFailure.fold(
        (failure) => emit(state.copyWith(
            status: FormzStatus.submissionFailure, failure: failure)),
        (success) =>
            emit(state.copyWith(status: FormzStatus.submissionSuccess)),
      );
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

import 'dart:async';

import 'package:auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_challenge/core/validators/email.dart';
import 'package:rick_and_morty_challenge/core/validators/password.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required IAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState());

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

  FutureOr<void> loginSubmission() async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final email = state.email;
      final password = state.password;

      final successOrFailure = await _authRepository.loginWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      successOrFailure.fold(
        (failure) => emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            failure: failure,
          ),
        ),
        (success) =>
            emit(state.copyWith(status: FormzStatus.submissionSuccess)),
      );
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

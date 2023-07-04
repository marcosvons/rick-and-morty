import 'dart:async';

import 'package:auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required IAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const _Unauthenticated()) {
    on<_AuthStateChanges>(_onAuthStateChanged);
    on<_Logout>(_onLogout);

    add(const _AuthStateChanges());
  }

  final IAuthRepository _authRepository;

  Future<void> _onAuthStateChanged(
    _AuthStateChanges event,
    Emitter<AuthState> emit,
  ) async {
    //TODO: emit forEach
    await emit.forEach(
      _authRepository.user,
      onData: (Option<User> user) {
        return user.fold(
          () => const _Unauthenticated(),
          (_) => const _Authenticated(),
        );
      },
    );
  }

  FutureOr<void> _onLogout(
    _Logout event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout();
  }
}

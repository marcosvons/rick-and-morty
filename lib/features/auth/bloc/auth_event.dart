part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authStateChanges() = _AuthStateChanges;
  const factory AuthEvent.logout() = _Logout;
}

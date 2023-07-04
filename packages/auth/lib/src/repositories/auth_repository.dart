import 'package:auth/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, Unit>> logout();
  Stream<Option<User>> get user;
}

class AuthRepository implements IAuthRepository {
  @override
  Stream<Option<User>> get user =>
      FirebaseAuth.instance.authStateChanges().map((User? user) {
        if (user != null) {
          return some(user);
        } else {
          return none();
        }
      });

  @override
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return const Left(AuthFailure.userNotFoundError());
        case 'wrong-password':
          return const Left(AuthFailure.invalidCredentialsError());
        default:
          return const Left(AuthFailure());
      }
    } catch (e) {
      return const Left(AuthFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return const Left(
          AuthFailure.emailAlreadyExistsError(),
        );
      } else {
        return const Left(AuthFailure());
      }
    } catch (e) {
      return const Left(AuthFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(unit);
    } catch (e) {
      return const Left(AuthFailure());
    }
  }
}

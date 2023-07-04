import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure() = _Failure;
  const factory Failure.internalServerError() = InternalServerError;
  const factory Failure.networkError() = NetworkError;
  const factory Failure.cacheError() = CacheError;
  const factory Failure.unauthorizedError() = UnauthorizedError;
  const factory Failure.emailAlreadyExistsError() = EmailAlreadyExistsError;
  const factory Failure.userNotFoundError() = UserNotFoundError;
  const factory Failure.notFoundError() = NotFoundError;
  const factory Failure.invalidCredentialsError() = InvalidCredentialsError;
  const factory Failure.tokenExpiredError() = TokenExpiredError;
  const factory Failure.unexpectedError() = UnexpectedError;
  const factory Failure.unknownError() = UnknownError;
}

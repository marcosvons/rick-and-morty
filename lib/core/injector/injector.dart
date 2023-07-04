import 'package:auth/auth.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt.registerLazySingleton<IAuthRepository>(AuthRepository.new);
}

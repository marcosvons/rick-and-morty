import 'package:auth/auth.dart';
import 'package:characters_package/characters.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_challenge/core/core.dart';

GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  final hiveBoxes = HiveBoxes();
  await hiveBoxes.initBoxes();

  getIt
    ..registerLazySingleton(() => hiveBoxes)
    ..registerLazySingleton<IAuthRepository>(AuthRepository.new)
    ..registerLazySingleton<ICharactersRepository>(
      () => CharactersRepository(
        charactersService: getIt<ICharactersService>(),
      ),
    )
    ..registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: 'https://rickandmortyapi.com/api/',
          connectTimeout: const Duration(milliseconds: 10000),
          receiveTimeout: const Duration(milliseconds: 10000),
          contentType: 'application/json',
          responseType: ResponseType.plain,
        ),
      ),
    )
    ..registerLazySingleton<ICharactersService>(
      () => CharactersService(
        dio: getIt<Dio>(),
      ),
    );
}

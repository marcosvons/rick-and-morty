part of 'characters_bloc.dart';

@freezed
class CharactersState with _$CharactersState {
  const factory CharactersState.initial() = _Initial;
  const factory CharactersState.loading() = _Loading;
  const factory CharactersState.loaded({
    required List<Character> characters,
    required int page,
    required bool hasReachedMax,
  }) = _Loaded;
  const factory CharactersState.error({required Failure failure}) = _Error;
}

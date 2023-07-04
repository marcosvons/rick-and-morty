part of 'characters_bloc.dart';

@freezed
class CharactersEvent with _$CharactersEvent {
  const factory CharactersEvent.getCharacters({@Default(1) int page}) =
      _GetCharacters;
  const factory CharactersEvent.setAsFavorite({required Character character}) =
      _SetAsFavorite;
  const factory CharactersEvent.deleteFavorite({required int characterId}) =
      _DeleteFavorite;
}

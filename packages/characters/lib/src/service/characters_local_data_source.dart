import 'package:characters_package/characters.dart';

abstract class ICharactersLocalDataSource {
  Future<void> addCharacterToFavorites(CharacterDto characterDto);
  List<CharacterDto> getFavoriteCharacters();
  Future<void> removeCharacterFromFavorites(int id);
}

class CharactersLocalDataSource implements ICharactersLocalDataSource {
  @override
  Future<void> addCharacterToFavorites(CharacterDto characterDto) {
    // TODO: implement addCharacterToFavorites
    throw UnimplementedError();
  }

  @override
  List<CharacterDto> getFavoriteCharacters() {
    // TODO: implement getFavoriteCharacters
    throw UnimplementedError();
  }

  @override
  Future<void> removeCharacterFromFavorites(int id) {
    // TODO: implement removeCharacterFromFavorites
    throw UnimplementedError();
  }
}

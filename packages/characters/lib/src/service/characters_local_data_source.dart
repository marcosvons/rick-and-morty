import 'dart:convert';

import 'package:characters_package/characters.dart';
import 'package:core/core.dart';
import 'package:hive/hive.dart';

abstract class ICharactersLocalDataSource {
  Future<void> addCharacterToFavorites(CharacterDto characterDto);
  List<CharacterDto> getFavoriteCharacters();
  Future<void> removeCharacterFromFavorites(int id);
}

class CharactersLocalDataSource implements ICharactersLocalDataSource {
  CharactersLocalDataSource({
    required Box<String> box,
  }) : _box = box;

  final Box<String> _box;

  @override
  Future<void> addCharacterToFavorites(CharacterDto characterDto) async {
    try {
      await _box.put(characterDto.id.toString(), jsonEncode(characterDto));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  List<CharacterDto> getFavoriteCharacters() {
    try {
      final characters = <CharacterDto>[];
      for (final key in _box.keys) {
        final character = _box.get(key);
        if (character != null) {
          final characterDto = CharacterDto.fromJson(
            jsonDecode(character) as Map<String, dynamic>,
          );
          characters.add(characterDto);
        }
      }
      return characters;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> removeCharacterFromFavorites(int id) {
    try {
      return _box.delete(id);
    } catch (e) {
      throw CacheException();
    }
  }
}

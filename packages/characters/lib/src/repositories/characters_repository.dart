// ignore_for_file: public_member_api_docs

import 'package:characters_package/characters.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class ICharactersRepository {
  Future<Either<Failure, List<Character>>> getCharacters({required int page});
  Future<Either<Failure, Unit>> setCharacterAsFavorite({
    required Character character,
  });
  Future<Either<Failure, Unit>> removeCharacterFromFavorites({
    required int characterId,
  });
  Either<Failure, List<Character>> getFavoriteCharacters();
}

class CharactersRepository implements ICharactersRepository {
  CharactersRepository({
    required ICharactersService charactersService,
    required ICharactersLocalDataSource charactersLocalDataSource,
  })  : _charactersService = charactersService,
        _charactersLocalDataSource = charactersLocalDataSource;

  final ICharactersService _charactersService;
  final ICharactersLocalDataSource _charactersLocalDataSource;

  @override
  Future<Either<Failure, List<Character>>> getCharacters({
    required int page,
  }) async {
    final characters = <Character>[];

    try {
      final charactersDto = await _charactersService.getCharacters(page: page);
      for (final characterDto in charactersDto) {
        final episodes = <EpisodeDto>[];
        final episodesId = <String>[];
        LocationDto? locationDto;
        LocationDto? originDto;

        for (final episodeUrl in characterDto.episode) {
          episodesId.add(episodeUrl.substring(episodeUrl.lastIndexOf('/') + 1));
        }

        if (episodesId.isNotEmpty) {
          episodes.addAll(
            await _charactersService.getEpisodes(episodesId: episodesId),
          );
        }
        final locationIds = <String>[];
        var locationExists = false;
        var originExists = false;
        if (characterDto.location['url']!.isNotEmpty) {
          locationIds.add(
            characterDto.location['url']!
                .substring(characterDto.location['url']!.lastIndexOf('/') + 1),
          );
          locationExists = true;
        }
        if (characterDto.origin['url']!.isNotEmpty) {
          locationIds.add(
            characterDto.origin['url']!
                .substring(characterDto.origin['url']!.lastIndexOf('/') + 1),
          );
          originExists = true;
        }

        if (locationIds.isNotEmpty) {
          final locations = await _charactersService.getLocations(
            locationIds: locationIds,
          );
          if (locationExists) {
            locationDto = locations.first;
          }
          if (originExists) {
            originDto = locations.last;
          }
        }

        characters.add(
          characterDto.toModel(
            episodes: episodes,
            location: locationDto,
            origin: originDto,
          ),
        );
      }

      return Right(characters);
    } on ConnectionErrorException {
      return const Left(Failure.http());
    } on TimeoutException {
      return const Left(Failure.connectTimeout());
    } on UnknownNetworkException {
      return const Left(Failure.unknown());
    } on JsonDeserializationException {
      return const Left(Failure.jsonDes());
    } catch (e) {
      return const Left(Failure.parseModel());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeCharacterFromFavorites({
    required int characterId,
  }) async {
    try {
      await _charactersLocalDataSource
          .removeCharacterFromFavorites(characterId);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cache());
    }
  }

  @override
  Future<Either<Failure, Unit>> setCharacterAsFavorite({
    required Character character,
  }) async {
    try {
      await _charactersLocalDataSource
          .addCharacterToFavorites(CharacterDto.fromModel(character));
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cache());
    }
  }

  @override
  Either<Failure, List<Character>> getFavoriteCharacters() {
    try {
      return Right(
        _charactersLocalDataSource
            .getFavoriteCharacters()
            .map((e) => e.toModel(episodes: []))
            .toList(),
      );
    } catch (e) {
      return const Left(Failure.cache());
    }
  }
}

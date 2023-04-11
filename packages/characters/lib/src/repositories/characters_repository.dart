// ignore_for_file: public_member_api_docs

import 'package:characters_package/characters.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class ICharactersRepository {
  Future<Either<Failure, List<Character>>> getCharacters({required int page});
  Either<Failure, Unit> setCharacterAsFavorite({required Character character});
  Either<Failure, Unit> removeCharacterFromFavorites({
    required int characterId,
  });
}

class CharactersRepository implements ICharactersRepository {
  CharactersRepository({required ICharactersService charactersService})
      : _charactersService = charactersService;

  final ICharactersService _charactersService;

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
  Either<Failure, Unit> removeCharacterFromFavorites({
    required int characterId,
  }) {
    // TODO: implement removeCharacterFromFavorites
    throw UnimplementedError();
  }

  @override
  Either<Failure, Unit> setCharacterAsFavorite({required Character character}) {
    // TODO: implement setCharacterAsFavorite
    throw UnimplementedError();
  }
}

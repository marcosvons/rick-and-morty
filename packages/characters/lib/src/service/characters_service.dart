// ignore_for_file: public_member_api_docs, prefer_single_quotes

import 'dart:convert';

import 'package:characters_package/characters.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ICharactersService {
  Future<List<CharacterDto>> getCharacters({required int page});
  Future<List<LocationDto>> getLocations({required List<String> locationIds});
  Future<List<EpisodeDto>> getEpisodes({required List<String> episodesId});
  Future<Unit> setCharacterAsFavorite({required Character character});
  Future<Unit> removeCharacterFromFavorites({required int characterId});
}

class CharactersService implements ICharactersService {
  CharactersService({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<CharacterDto>> getCharacters({int page = 1}) async {
    Response response;

    try {
      response = await _dio.get(
        "character/?page=$page",
      );
    } on DioError {
      throw ConnectionErrorException();
    } catch (e) {
      throw UnknownNetworkException();
    }

    try {
      final responseData =
          jsonDecode(response.data as String) as Map<String, dynamic>;
      final charactersDto = (responseData['results'] as List)
          .map(
            (dynamic character) =>
                CharacterDto.fromJson(character as Map<String, dynamic>),
          )
          .toList();
      return charactersDto;
    } catch (e) {
      throw JsonDeserializationException();
    }
  }

  @override
  Future<Unit> removeCharacterFromFavorites({required int characterId}) {
    // TODO: implement removeCharacterFromFavorites
    throw UnimplementedError();
  }

  @override
  Future<Unit> setCharacterAsFavorite({required Character character}) {
    // TODO: implement setCharacterAsFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<EpisodeDto>> getEpisodes({
    required List<String> episodesId,
  }) async {
    Response response;

    try {
      response = await _dio.get(
        "episode/${episodesId.join(',')}",
      );
    } on DioError catch (e) {
      print(e);
      throw ConnectionErrorException();
    } catch (e) {
      throw UnknownNetworkException();
    }

    try {
      final responseData = jsonDecode(response.data as String);
      if (episodesId.length == 1) {
        return [EpisodeDto.fromJson(responseData as Map<String, dynamic>)];
      }
      final episodesDto = (responseData as List<dynamic>)
          .map(
            (dynamic episode) =>
                EpisodeDto.fromJson(episode as Map<String, dynamic>),
          )
          .toList();
      return episodesDto;
    } catch (e) {
      throw JsonDeserializationException();
    }
  }

  @override
  Future<List<LocationDto>> getLocations({
    required List<String> locationIds,
  }) async {
    Response response;

    try {
      response = await _dio.get(
        "location/${locationIds.join(",")}",
      );
    } on DioError {
      throw ConnectionErrorException();
    } catch (e) {
      throw UnknownNetworkException();
    }

    try {
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.data as String);
        if (locationIds.length == 1) {
          return [LocationDto.fromJson(responseData as Map<String, dynamic>)];
        } else {
          final locationsDto = (responseData as List<dynamic>)
              .map(
                (dynamic location) =>
                    LocationDto.fromJson(location as Map<String, dynamic>),
              )
              .toList();
          return locationsDto;
        }
      } else {
        return <LocationDto>[];
      }
    } catch (e) {
      throw JsonDeserializationException();
    }
  }
}

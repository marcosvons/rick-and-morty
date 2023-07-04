// ignore_for_file: public_member_api_docs

import 'package:characters_package/characters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_dto.freezed.dart';
part 'character_dto.g.dart';

@freezed
class CharacterDto with _$CharacterDto {
  const factory CharacterDto({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required Map<String, String> origin,
    required Map<String, String> location,
    required String image,
    required List<String> episode,
    required String url,
    required String created,
  }) = _CharacterDto;
  factory CharacterDto.fromModel(Character character) => CharacterDto(
        id: character.id,
        name: character.name,
        status: character.status,
        species: character.species,
        type: character.type,
        gender: character.gender,
        origin: {},
        location: {},
        image: character.image,
        episode: [],
        url: character.url,
        created: character.created.toIso8601String(),
      );

  const CharacterDto._();

  factory CharacterDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterDtoFromJson(json);

  Character toModel({
    required List<EpisodeDto> episodes,
    LocationDto? location,
    LocationDto? origin,
  }) {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      origin: origin?.toModel(),
      location: location?.toModel(),
      image: image,
      episode: episodes.map((e) => e.toModel()).toList(),
      url: url,
      created: DateTime.parse(created),
    );
  }
}

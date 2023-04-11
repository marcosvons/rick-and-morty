// ignore_for_file: public_member_api_docs

import 'package:characters_package/characters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode_dto.freezed.dart';
part 'episode_dto.g.dart';

@freezed
class EpisodeDto with _$EpisodeDto {
  const factory EpisodeDto({
    required int id,
    required String name,
    @JsonKey(name: 'air_date') required String airDate,
    required String episode,
    required List<String> characters,
    required String url,
    required String created,
  }) = _EpisodeDto;

  const EpisodeDto._();

  factory EpisodeDto.fromJson(Map<String, dynamic> json) =>
      _$EpisodeDtoFromJson(json);

  Episode toModel() {
    return Episode(
      id: id,
      name: name,
      airDate: airDate,
      episode: episode,
      url: url,
      created: DateTime.parse(created),
    );
  }
}

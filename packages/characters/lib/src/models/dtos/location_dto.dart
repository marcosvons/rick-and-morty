// ignore_for_file: public_member_api_docs

import 'package:characters_package/characters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_dto.freezed.dart';
part 'location_dto.g.dart';

@freezed
class LocationDto with _$LocationDto {
  const factory LocationDto({
    required int id,
    required String name,
    required String type,
    required String dimension,
    required List<String> residents,
    required String url,
    required String created,
  }) = _LocationDto;

  const LocationDto._();

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  Location toModel() {
    return Location(
      id: id,
      name: name,
      type: type,
      dimension: dimension,
      url: url,
      created: DateTime.parse(created),
    );
  }
}

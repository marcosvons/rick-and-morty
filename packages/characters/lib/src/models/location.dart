// ignore_for_file: public_member_api_docs

import 'package:characters_package/characters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';

@freezed
class Location with _$Location {
  const factory Location({
    required int id,
    required String name,
    required String type,
    required String dimension,
    List<Character>? residents,
    required String url,
    required DateTime created,
  }) = _Location;
}

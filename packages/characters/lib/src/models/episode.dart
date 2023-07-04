// ignore_for_file: public_member_api_docs

import 'package:characters_package/characters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';

@freezed
class Episode with _$Episode {
  const factory Episode({
    required int id,
    required String name,
    required String airDate,
    required String episode,
    List<Character>? characters,
    required String url,
    required DateTime created,
  }) = _Episode;
}

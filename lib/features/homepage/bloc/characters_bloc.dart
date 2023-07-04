import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:characters_package/characters.dart';
import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'characters_event.dart';
part 'characters_state.dart';
part 'characters_bloc.freezed.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc({required ICharactersRepository charactersRepository})
      : _charactersRepository = charactersRepository,
        super(const _Initial()) {
    on<_GetCharacters>(_onGetCharacters);
  }

  final ICharactersRepository _charactersRepository;

  FutureOr<void> _onGetCharacters(
    _GetCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(const _Loading());
    final result = await _charactersRepository.getCharacters(page: event.page);
    result.fold(
      (failure) => emit(_Error(failure: failure)),
      (characters) {
        final hasReachedMax = characters.isEmpty;
        emit(
          _Loaded(
            characters: characters,
            page: event.page,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }
}

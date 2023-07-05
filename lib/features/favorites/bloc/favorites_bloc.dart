import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:characters_package/characters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';
part 'favorites_bloc.freezed.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required ICharactersRepository charactersRepository})
      : _charactersRepository = charactersRepository,
        super(const _Initial()) {
    on<_LoadFavorites>(_onLoadFavorites);
    on<_AddedToFavorites>(_onAddedToFavorites);
    on<_RemovedFromFavorites>(_onRemovedFromFavorites);
  }

  final ICharactersRepository _charactersRepository;

  FutureOr<void> _onLoadFavorites(
    _LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesState.loading());
    final possibleFavoritesOrFailure =
        _charactersRepository.getFavoriteCharacters()
          ..fold(
            (failure) => emit(FavoritesState.error(failure.toString())),
            (favorites) => emit(FavoritesState.loaded(favorites)),
          );
  }

  FutureOr<void> _onAddedToFavorites(
    _AddedToFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final possibleFavoritesOrFailure = await _charactersRepository
        .setCharacterAsFavorite(character: event.character);
    possibleFavoritesOrFailure.fold(
      (failure) => emit(FavoritesState.error(failure.toString())),
      (_) => state.maybeWhen(
        orElse: () {},
        loaded: (favorites) {
          final newFavorites = <Character>[...favorites, event.character];
          emit(FavoritesState.loaded(newFavorites));
        },
      ),
    );
  }

  FutureOr<void> _onRemovedFromFavorites(
    _RemovedFromFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final possibleFavoritesOrFailure = await _charactersRepository
        .removeCharacterFromFavorites(characterId: event.character.id);
    possibleFavoritesOrFailure.fold(
      (failure) => emit(FavoritesState.error(failure.toString())),
      (_) => state.maybeWhen(
        orElse: () {},
        loaded: (favorites) {
          final newFavorites = favorites
              .where((favorite) => favorite.id != event.character.id)
              .toList();
          emit(FavoritesState.loaded(newFavorites));
        },
      ),
    );
  }
}

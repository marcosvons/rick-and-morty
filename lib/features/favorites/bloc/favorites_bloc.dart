import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:characters_package/characters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';
part 'favorites_bloc.freezed.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required Box box})
      : _box = box,
        super(const _Initial()) {
    on<_LoadFavorites>(_onLoadFavorites);
    on<_AddedToFavorites>(_onAddedToFavorites);
    on<_RemovedFromFavorites>(_onRemovedFromFavorites);
  }

  final Box _box;

  FutureOr<void> _onLoadFavorites(event, Emitter<FavoritesState> emit) {
    emit(const FavoritesState.loading());
    final favorites = _box.values.toList();
    final charactersList = ii
    emit(FavoritesState.loaded(favorites));
  }

  FutureOr<void> _onAddedToFavorites(event, Emitter<FavoritesState> emit) {}

  FutureOr<void> _onRemovedFromFavorites(event, Emitter<FavoritesState> emit) {}
}

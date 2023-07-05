part of 'favorites_bloc.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.addedToFavorites({
    required Character character,
  }) = _AddedToFavorites;
  const factory FavoritesEvent.removedFromFavorites(Character character) =
      _RemovedFromFavorites;
  const factory FavoritesEvent.loadFavorites() = _LoadFavorites;
}

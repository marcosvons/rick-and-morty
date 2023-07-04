part of 'favorites_bloc.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.addedToFavorites() = _AddedToFavorites;
  const factory FavoritesEvent.removedFromFavorites() = _RemovedFromFavorites;
  const factory FavoritesEvent.loadFavorites() = _LoadFavorites;
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/feature/home/data/model/populer_model.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial()) {
    emit(const FavoritesLoaded(favorites: []));
  }

  void addToFavorites(Results person) {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      final updatedFavorites = List<Results>.from(currentState.favorites);

      if (!updatedFavorites.any((p) => p.id == person.id)) {
        updatedFavorites.add(person);
        emit(FavoritesLoaded(favorites: updatedFavorites));
      }
    }
  }

  void removeFromFavorites(Results person) {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      final updatedFavorites =
          currentState.favorites.where((p) => p.id != person.id).toList();

      emit(FavoritesLoaded(favorites: updatedFavorites));
    }
  }

  void toggleFavorite(Results person) {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      final isFavorite = currentState.favorites.any((p) => p.id == person.id);

      if (isFavorite) {
        removeFromFavorites(person);
      } else {
        addToFavorites(person);
      }
    }
  }

  bool isFavorite(Results person) {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      return currentState.favorites.any((p) => p.id == person.id);
    }
    return false;
  }

  List<Results> getFavorites() {
    if (state is FavoritesLoaded) {
      return (state as FavoritesLoaded).favorites;
    }
    return [];
  }

  void clearAllFavorites() {
    emit(const FavoritesLoaded(favorites: []));
  }
}

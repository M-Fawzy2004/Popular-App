import 'package:equatable/equatable.dart';
import 'package:first_app/feature/home/data/model/populer_model.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Results> favorites;

  const FavoritesLoaded({required this.favorites});

  @override
  List<Object> get props => [favorites];

  FavoritesLoaded copyWith({List<Results>? favorites}) {
    return FavoritesLoaded(
      favorites: favorites ?? this.favorites,
    );
  }
}
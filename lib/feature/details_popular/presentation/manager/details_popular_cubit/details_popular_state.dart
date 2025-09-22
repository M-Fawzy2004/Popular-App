part of 'details_popular_cubit.dart';

@immutable
sealed class DetailsPopularState {}

final class DetailsPopularInitial extends DetailsPopularState {}

final class DetailsPopularLoading extends DetailsPopularState {}

final class DetailsPopularSuccess extends DetailsPopularState {}

final class DetailsPopularError extends DetailsPopularState {}

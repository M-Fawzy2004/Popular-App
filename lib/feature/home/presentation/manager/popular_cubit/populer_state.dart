part of 'populer_cubit.dart';

@immutable
sealed class PopulerState {}

final class PopulerInitial extends PopulerState {}

final class PopulerLoading extends PopulerState {}

final class PopulerSuccess extends PopulerState {
  final PopularModel popularModel;
  PopulerSuccess(this.popularModel);
}

final class PopulerError extends PopulerState {
  final String message;
  PopulerError(this.message);
}

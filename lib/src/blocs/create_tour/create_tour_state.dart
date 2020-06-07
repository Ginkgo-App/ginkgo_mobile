part of 'create_tour_bloc.dart';

@immutable
abstract class CreateTourState {
  @override
  String toString() => runtimeType.toString();
}

class CreateTourInitial extends CreateTourState {}

class CreateTourStateHaveChanged extends CreateTourState {
  final bool validation;
  final TourToPost tourToPost;

  CreateTourStateHaveChanged(this.validation, this.tourToPost);
}

class CreateTourStateLoading extends CreateTourState {}

class CreateTourStateSuccess extends CreateTourState {}

class CreateTourStateFailure extends CreateTourState {
  final dynamic error;

  CreateTourStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}

part of 'create_tour_info_bloc.dart';

@immutable
abstract class CreateTourInfoState {
  @override
  String toString() => runtimeType.toString();
}

class CreateTourInfoInitial extends CreateTourInfoState {}

class CreateTourInfoStateHaveChanged extends CreateTourInfoState {
  final bool validation;
  final TourToPost tourToPost;

  CreateTourInfoStateHaveChanged(this.validation, this.tourToPost);
}

class CreateTourInfoStateLoading extends CreateTourInfoState {}

class CreateTourInfoStateSuccess extends CreateTourInfoState {
  final int newTourInfoId;

  CreateTourInfoStateSuccess(this.newTourInfoId);

  @override
  String toString() => '$runtimeType $newTourInfoId';
}

class CreateTourInfoStateFailure extends CreateTourInfoState {
  final dynamic error;

  CreateTourInfoStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}

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
  final TourInfo newTourInfo;

  CreateTourInfoStateSuccess(this.newTourInfo);

  @override
  String toString() => '$runtimeType $newTourInfo';
}

class CreateTourInfoStateFailure extends CreateTourInfoState {
  final dynamic error;

  CreateTourInfoStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}

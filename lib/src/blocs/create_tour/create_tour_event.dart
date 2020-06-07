part of 'create_tour_bloc.dart';

@immutable
abstract class CreateTourEvent {
  @override
  String toString() => runtimeType.toString();
}

class CreateTourEventCreate extends CreateTourEvent {}

class CreateTourEventChangeData extends CreateTourEvent {
  final bool validation;
  final TourToPost tourToPost;

  CreateTourEventChangeData(this.validation, this.tourToPost);

  @override
  String toString() =>
      '$runtimeType ${tourToPost.toJsonString()}  Validator: $validation';
}

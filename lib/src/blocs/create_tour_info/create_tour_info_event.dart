part of 'create_tour_info_bloc.dart';

@immutable
abstract class CreateTourInfoEvent {
  @override
  String toString() => runtimeType.toString();
}

class CreateTourInfoEventCreate extends CreateTourInfoEvent {
  final TourInfoToPost tourInfoToPost;

  CreateTourInfoEventCreate(this.tourInfoToPost);

  @override
  String toString() =>
      '$runtimeType {startPlace: ${tourInfoToPost.startPlace.id}}';
}

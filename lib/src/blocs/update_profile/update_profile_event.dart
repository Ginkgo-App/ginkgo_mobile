part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileEvent {
  @override
  String toString() => runtimeType.toString();
}

class UpdateProfileEventUpdate extends UpdateProfileEvent {
  final UserToPut userToPut;

  UpdateProfileEventUpdate(this.userToPut);

  @override
  String toString() => '$runtimeType ${userToPut.toJson()}';
}

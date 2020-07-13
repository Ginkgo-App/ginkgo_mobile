part of 'manage_tour_members_bloc.dart';

@immutable
abstract class ManageTourMembersEvent {}

class ManageTourMembersEventAccept extends ManageTourMembersEvent {
  final int userId;
  final int tourId;

  ManageTourMembersEventAccept(this.userId, this.tourId);
}

class ManageTourMembersEventRemove extends ManageTourMembersEvent {
  final int userId;
  final int tourId;

  ManageTourMembersEventRemove(this.userId, this.tourId);
}

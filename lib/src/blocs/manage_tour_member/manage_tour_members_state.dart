part of 'manage_tour_members_bloc.dart';

@immutable
abstract class ManageTourMembersState {}

class ManageTourMembersInitial extends ManageTourMembersState {}

class ManageTourMembersStateLoading extends ManageTourMembersState {
  final int userId;
  final int tourId;

  ManageTourMembersStateLoading(this.userId, this.tourId);
}

class ManageTourMembersStateSuccess extends ManageTourMembersState {
  final int userId;
  final int tourId;

  ManageTourMembersStateSuccess(this.userId, this.tourId);
}

class ManageTourMembersStateFailure extends ManageTourMembersState {
  final int userId;
  final int tourId;
  final dynamic error;

  ManageTourMembersStateFailure(this.userId, this.error, this.tourId);
}

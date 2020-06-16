part of 'tour_members_bloc.dart';

@immutable
abstract class TourMembersState {
  @override
  String toString() => runtimeType.toString();
}

class TourMembersInitial extends TourMembersState {}

class TourMembersStateLoading extends TourMembersState {}

class TourMembersStateSuccess extends TourMembersState {
  final Pagination<TourMember> members;

  TourMembersStateSuccess(this.members);

  @override
  String toString() =>
      '$runtimeType ${members.data.length} / ${members.pagination.totalPage}';
}

class TourMembersStateFailure extends TourMembersState {
  final dynamic error;

  TourMembersStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'tour_members_event.dart';
part 'tour_members_state.dart';

class TourMembersBloc extends Bloc<TourMembersEvent, TourMembersState> {
  final Repository _repository = Repository();
  final int _pageSize;

  String _keyword;

  Pagination<TourMember> _memberList = Pagination<TourMember>();

  Pagination<TourMember> get memberList => _memberList;

  TourMembersBloc(this._pageSize);

  @override
  TourMembersState get initialState => TourMembersInitial();

  @override
  Stream<TourMembersState> mapEventToState(
    TourMembersEvent event,
  ) async* {
    try {
      if (event is TourMembersEventFetch && _memberList.canLoadmore) {
        yield TourMembersStateLoading();

        if (event.keyword != null) {
          _keyword = event.keyword;
        }

        _memberList.add(
          await _repository.tour.getMembers(
            event.tourId,
            pageSize: _pageSize,
            page: _memberList.pagination.currentPage + 1,
            keyword: _keyword,
            type: event.type,
          ),
        );

        yield TourMembersStateSuccess(_memberList);
      }
    } catch (e) {
      yield TourMembersStateFailure(e);
    }
  }
}

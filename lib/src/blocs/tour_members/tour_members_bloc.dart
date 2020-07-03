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
  final int _tourId;
  final TourMemberType _type;

  String _keyword;

  Pagination<TourMember> _memberList = Pagination<TourMember>();

  Pagination<TourMember> get memberList => _memberList;

  TourMembersBloc(this._pageSize, this._tourId, this._type);

  @override
  TourMembersState get initialState => TourMembersInitial();

  @override
  Stream<TourMembersState> mapEventToState(
    TourMembersEvent event,
  ) async* {
    try {
      if (event is TourMembersEventFetch) {
        yield TourMembersStateLoading();

        _keyword = event.keyword;

        _memberList.add(
          await _repository.tour.getMembers(
            _tourId,
            pageSize: _pageSize,
            page: 1,
            keyword: _keyword,
            type: _type,
          ),
        );

        yield TourMembersStateSuccess(_memberList);
      } else if (event is TourMembersEventLoadMore &&
          _memberList.canLoadmore &&
          (state is! TourMembersStateFailure || event.force)) {
        yield TourMembersStateLoading();

        _memberList.add(
          await _repository.tour.getMembers(
            _tourId,
            pageSize: _pageSize,
            page: _memberList.pagination.currentPage + 1,
            keyword: _keyword,
            type: _type,
          ),
        );

        yield TourMembersStateSuccess(_memberList);
      }
    } catch (e) {
      yield TourMembersStateFailure(e);
    }
  }
}

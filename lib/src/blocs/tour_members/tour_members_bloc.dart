import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/blocs/manage_tour_member/manage_tour_members_bloc.dart';
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
  final ManageTourMembersBloc manageTourMembersBloc;

  String _keyword;

  Pagination<TourMember> _memberList = Pagination<TourMember>();

  Pagination<TourMember> get memberList => _memberList;

  StreamSubscription manageBlocListener;

  TourMembersBloc(this._pageSize, this._tourId, this._type)
      : manageTourMembersBloc = ManageTourMembersBloc() {
    manageBlocListener = manageTourMembersBloc.listen((state) {
      if (state is ManageTourMembersStateSuccess && state.tourId == _tourId) {
        this.add(TourMembersEventFetch());
      }
    });
  }

  @override
  Future<void> close() {
    manageBlocListener.cancel();
    return super.close();
  }

  @override
  TourMembersState get initialState => TourMembersInitial();

  @override
  Stream<TourMembersState> mapEventToState(TourMembersEvent event) async* {
    try {
      if (event is TourMembersEventFetch) {
        yield TourMembersStateLoading();

        _keyword = event.keyword;

        _memberList = await _repository.tour.getMembers(
          _tourId,
          pageSize: _pageSize,
          page: 1,
          keyword: _keyword,
          type: _type,
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
      } else if (event is TourMembersEventOnChange) {
        yield TourMembersStateSuccess(_memberList);
      }
    } catch (e) {
      yield TourMembersStateFailure(e);
    }
  }
}

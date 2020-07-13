import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'top_user_event.dart';
part 'top_user_state.dart';

class TopUserBloc extends Bloc<TopUserEvent, TopUserState> {
  TopUserBloc(this.pageSize);

  final Repository _repository = Repository();
  final int pageSize;

  Pagination<SimpleUser> _topUserList = Pagination();
  Pagination<SimpleUser> get topUserList => _topUserList;

  @override
  TopUserState get initialState => TopUserInitial();

  @override
  Stream<TopUserState> mapEventToState(TopUserEvent event) async* {
    try {
      if (event is TopUserEventFetch) {
        _topUserList = Pagination();
        yield TopUserStateLoading();

        int nextPage = _topUserList.pagination.currentPage + 1;

        _topUserList.add(await _repository.user.getTopUsers(
          pageSize: pageSize,
          page: nextPage,
        ));

        yield TopUserStateSuccess(_topUserList);
      } else if (event is TopUserEventLoadMore &&
          _topUserList.canLoadmore &&
          (state is! TopUserStateFailure || event.force)) {
        yield TopUserStateLoading();

        _topUserList.add(await _repository.user.getTopUsers(
          pageSize: pageSize,
          page: _topUserList.pagination.currentPage + 1,
        ));

        yield TopUserStateSuccess(_topUserList);
      }
    } catch (e) {
      yield TopUserStateFailure(e);
    }
  }
}

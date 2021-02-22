import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'notification_list_event.dart';
part 'notification_list_state.dart';

class NotificationListBloc
    extends Bloc<NotificationListEvent, NotificationListState> {
  NotificationListBloc(this.pageSize);

  final Repository _repository = Repository();
  final int pageSize;

  Pagination<NotificationInfo> _notificationList = Pagination();
  Pagination<NotificationInfo> get notificationList => _notificationList;

  @override
  NotificationListState get initialState => NotificationListInitial();

  @override
  Stream<NotificationListState> mapEventToState(
      NotificationListEvent event) async* {
    try {
      if (event is CallEventChangeState) {
        yield event.state;
      } else if (event is NotificationListEventFetch) {
        _notificationList = Pagination();
        yield NotificationListStateLoading();

        int nextPage = _notificationList.pagination.currentPage + 1;

        _notificationList.add(await _repository.notification.getList(
          pageSize: pageSize,
          page: nextPage,
        ));

        yield NotificationListStateSuccess(_notificationList);
      } else if (event is NotificationListEventLoadMore &&
          _notificationList.canLoadmore &&
          (state is! NotificationListStateFailure || event.force)) {
        yield NotificationListStateLoading(isLoadMore: true);

        _notificationList.add(await _repository.notification.getList(
          pageSize: pageSize,
          page: _notificationList.pagination.currentPage + 1,
        ));

        yield NotificationListStateSuccess(_notificationList);
      }
    } catch (e) {
      yield NotificationListStateFailure(e);
    }
  }
}

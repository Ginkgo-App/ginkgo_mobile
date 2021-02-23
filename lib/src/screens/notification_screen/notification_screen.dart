part of '../screens.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationListBloc _notificationListBloc = NotificationListBloc(20);

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() {
    _notificationListBloc.add(NotificationListEventFetch());
  }

  dispose() {
    _notificationListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _notificationListBloc,
        builder: (context, state) {
          if (state is NotificationListStateFailure) {
            return ErrorIndicator(
              moreErrorDetail: state.error.toString(),
              onReload: _fetchData,
            );
          }

          return RefreshIndicator(
            onRefresh: () => _fetchData(),
            child: PrimaryScaffold(
                appBar: BackAppBar(title: 'Thông báo'),
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      if (state is NotificationListStateSuccess &&
                          _notificationListBloc.notificationList.data.length ==
                              0)
                        NotFoundWidget(
                          message: 'Không có thông báo mới.',
                          showBorderBox: false,
                        )
                      else if (state is NotificationListStateSuccess)
                        ListView(
                          itemExtent: null,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: [
                            ..._notificationListBloc.notificationList.data
                                .map((notification) => NotificationWidget(
                                      notification: notification,
                                    ))
                                .toList()
                          ],
                        )
                    ],
                  ),
                )),
          );
        });
  }
}

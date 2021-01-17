part of '../screens.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildListView(),
    );
  }
}

Widget _buildListView() {
  Notification notification = FakeData.notification;
  return ListView(
    itemExtent: null,
    shrinkWrap: true,
    padding: EdgeInsets.zero,
    children: [
      ...List.generate(
          10,
          (index) => NotificationWidget(
                notification: notification,
              )),
    ],
  );
}

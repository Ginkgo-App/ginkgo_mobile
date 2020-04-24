part of '../screens.dart';

class ProfileScreen extends StatelessWidget {
  final User user = FakeData.currentUser;

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AvatarWidget(user: user),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  OwnerNav(),
                  AboutBox(user: user),
                  TourListWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

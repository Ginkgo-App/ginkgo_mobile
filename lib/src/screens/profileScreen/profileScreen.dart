part of '../screens.dart';

class ProfileScreen extends StatelessWidget {
  final User user = FakeData.currentUser;

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(title: user.fullName),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AvatarWidget(user: user),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  OwnerNav(),
                  const SizedBox(height: 10),
                  AboutBox(user: user),
                  const SizedBox(height: 10),
                  FriendList(),
                  const SizedBox(height: 10),
                  InfoBox(),
                  const SizedBox(height: 10),
                  TourListWidget(),
                  const SizedBox(height: 10),
                  ActivityBox(),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

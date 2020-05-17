part of '../screens.dart';

class ProfileListTourScreen extends StatefulWidget {
  @override
  _ProfileListTourScreenState createState() => _ProfileListTourScreenState();
}

class _ProfileListTourScreenState extends State<ProfileListTourScreen> {
  @override
  Widget build(BuildContext context) {
    User currentUser = FakeData.currentUser;
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: currentUser?.fullName ?? '',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Avatar(
                isCircle: true,
                imageUrl: currentUser.avatar,
                size: 170,
              ),
              const SizedBox(height: 20),
              OwnerNav(),
              const SizedBox(height: 10),
              _buildTripItem(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripItem() {
    return BorderContainer(
      title: 'Tất cả các chuyến đi',
      icon: Assets.icons.tour,
      childPadding: EdgeInsets.zero,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: IntrinsicHeight(
          child: SpacingColumn(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            isSpacingHeadTale: true,
            children: [
              ...List.generate(3, (_) => FakeData.simpleTour)
                  .map((e) => TripItem(tour: e))
                  .toList(),
              CommonOutlineButton(
                text: 'Xem thêm',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

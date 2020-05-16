import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/models/tour.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/placeWidgets/opacityPlace.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/tourWidgets/tourItem.dart';
import 'package:ginkgo_mobile/src/widgets/userWidgets/circleUser.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class DiscoveryTab extends StatefulWidget {
  @override
  _DiscoveryTabState createState() => _DiscoveryTabState();
}

class _DiscoveryTabState extends State<DiscoveryTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SpacingColumn(
        spacing: 10,
        isSpacingHeadTale: true,
        children: <Widget>[
          _buildSuggestedCreators(),
          _buildSuggestedPlaces(),
          _buildNewTours(),
          _buildFriendTours(),
          _buildWillLikeTours(),
        ],
      ),
    );
  }

  Widget _buildSuggestedCreators() {
    return BorderContainer(
      margin: EdgeInsets.symmetric(horizontal: 10),
      title: 'Kết nối người tạo nên những chuyến đi',
      icon: Assets.icons.contributor,
      childPadding: EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: SpacingRow(
            spacing: 10,
            isSpacingHeadTale: true,
            children: List.generate(10, (_) => FakeData.currentUser)
                .map((e) => CircleUser())
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedPlaces() {
    return BorderContainer(
      title: 'Các địa điểm nổi bật',
      icon: Assets.icons.location,
      margin: EdgeInsets.symmetric(horizontal: 10),
      childPadding: EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: SpacingRow(
            spacing: 10,
            isSpacingHeadTale: true,
            children: List.generate(10, (_) => FakeData.place)
                .map(
                  (e) => OpacityPlace(place: e),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNewTours() {
    return _buildTourList('Các tour mới nhất', Assets.icons.newIcon,
        List.generate(10, (_) => FakeData.simpleTour));
  }

  Widget _buildFriendTours() {
    return _buildTourList('Bạn bè của bạn cũng tham gia',
        Assets.icons.friendList, List.generate(10, (_) => FakeData.simpleTour),
        showFriend: true);
  }

  Widget _buildWillLikeTours() {
    return _buildTourList('Có thể bạn sẽ thích', Assets.icons.tour,
        List.generate(10, (_) => FakeData.simpleTour));
  }

  Widget _buildTourList(String title, String icon, List<SimpleTour> tourList,
      {bool showFriend = false}) {
    return BorderContainer(
      title: title,
      icon: icon,
      margin: EdgeInsets.symmetric(horizontal: 10),
      childPadding: EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: SpacingRow(
            spacing: 20,
            isSpacingHeadTale: true,
            children: tourList
                .map(
                  (e) => TourItem(
                      tour: FakeData.simpleTour, showFriend: showFriend),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

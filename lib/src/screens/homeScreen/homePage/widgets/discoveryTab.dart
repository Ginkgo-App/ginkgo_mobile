import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/place_list/place_list_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/top_user/top_user_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/tour_list/tour_list_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/viewMoreButton.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/errorIndicator.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/showErrorMessage.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:base/base.dart';

class DiscoveryTab extends StatefulWidget {
  @override
  _DiscoveryTabState createState() => _DiscoveryTabState();
}

class _DiscoveryTabState extends State<DiscoveryTab> {
  final TopUserBloc _topUserBloc = TopUserBloc(10);
  final PlaceListBloc _bestPlaceBloc = PlaceListBloc(10);
  final TourListBloc _recommendToursBloc =
      TourListBloc(10, tourListType: TourListType.recommend);
  final TourListBloc _friendToursBloc =
      TourListBloc(10, tourListType: TourListType.friend);
  final TourListBloc _forYouToursBloc =
      TourListBloc(10, tourListType: TourListType.forYou);

  initState() {
    super.initState();
    loadData();
  }

  loadData() {
    _fetchTopUserList();
    _topUserBloc
        .waitOne([TopUserStateFailure, TopUserStateSuccess]).whenComplete(() {
      _fetchBestPlaceList();
      _bestPlaceBloc.waitOne(
          [PlaceListStateFailure, PlaceListStateSuccess]).whenComplete(() {
        _fetchRecommendTours();
        final tourListTypes = [TourListStateFailure, TourListStateSuccess];
        _recommendToursBloc.waitOne(tourListTypes).whenComplete(() {
          _fetchFriendTours();
          _friendToursBloc.waitOne(tourListTypes).whenComplete(() {
            _fetchForYouTours();
          });
        });
      });
    });
  }

  _fetchTopUserList() {
    _topUserBloc.add(TopUserEventFetch());
  }

  _fetchBestPlaceList() {
    _bestPlaceBloc.add(PlaceListEventFetchBestList());
  }

  _fetchRecommendTours() {
    _recommendToursBloc.add(TourListEventFetch(refresh: true));
  }

  _fetchFriendTours() {
    _friendToursBloc.add(TourListEventFetch(refresh: true));
  }

  _fetchForYouTours() {
    _forYouToursBloc.add(TourListEventFetch(refresh: true));
  }

  dispose() {
    _topUserBloc.close();
    _bestPlaceBloc.close();
    _recommendToursBloc.close();
    _friendToursBloc.close();
    _forYouToursBloc.close();
    super.dispose();
  }

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
      child: BlocBuilder(
        bloc: _topUserBloc,
        builder: (context, state) {
          if (state is TopUserStateFailure) {
            return ErrorIndicator(
              moreErrorDetail: state.error.toString(),
              onReload: _fetchTopUserList,
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: SpacingRow(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.center,
                isSpacingHeadTale: true,
                children: [
                  ...(state is TopUserStateSuccess
                          ? _topUserBloc.topUserList.data
                          : List.generate(10, (index) => null))
                      .map((e) => CircleTourUser(simpleUser: e))
                      .toList(),
                  if (state is TopUserStateSuccess &&
                      _topUserBloc.topUserList.canLoadmore)
                    ViewMoreButton(
                      onPressed: () {
                        showErrorMessage(Strings.common.developingFeature);
                      },
                      width: 100,
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuggestedPlaces() {
    return BorderContainer(
      title: 'Các địa điểm nổi bật',
      icon: Assets.icons.location,
      margin: EdgeInsets.symmetric(horizontal: 10),
      childPadding: EdgeInsets.only(bottom: 10),
      child: BlocBuilder(
        bloc: _bestPlaceBloc,
        builder: (context, state) {
          if (state is PlaceListStateFailure) {
            return ErrorIndicator(
              moreErrorDetail: state.error.toString(),
              onReload: _fetchBestPlaceList,
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child:
                  SpacingRow(spacing: 10, isSpacingHeadTale: true, children: [
                ...(state is PlaceListStateSuccess
                        ? _bestPlaceBloc.placeList.data
                        : List.generate(5, (index) => null))
                    .map(
                      (e) => OpacityPlace(place: e),
                    )
                    .toList(),
                if (state is PlaceListStateSuccess &&
                    _bestPlaceBloc.placeList.canLoadmore)
                  ViewMoreButton(
                    onPressed: () {
                      showErrorMessage(Strings.common.developingFeature);
                    },
                    width: (MediaQuery.of(context).size.width - 60) / 3,
                  )
              ]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewTours() {
    return _buildTourList(
        'Các tour mới nhất', Assets.icons.newIcon, _recommendToursBloc);
  }

  Widget _buildFriendTours() {
    return _buildTourList('Bạn bè của bạn cũng tham gia',
        Assets.icons.friendList, _friendToursBloc,
        showFriend: true);
  }

  Widget _buildWillLikeTours() {
    return _buildTourList(
        'Có thể bạn sẽ thích', Assets.icons.tour, _forYouToursBloc);
  }

  Widget _buildTourList(String title, String icon, TourListBloc tourListBloc,
      {bool showFriend = false}) {
    return BorderContainer(
      title: title,
      icon: icon,
      margin: EdgeInsets.symmetric(horizontal: 10),
      childPadding: EdgeInsets.only(bottom: 10),
      child: BlocBuilder(
          bloc: tourListBloc,
          builder: (context, state) {
            if (state is TourListStateFailure) {
              return ErrorIndicator(
                moreErrorDetail: state.error.toString(),
                onReload: () {
                  tourListBloc.add(TourListEventFetch(refresh: true));
                },
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicHeight(
                child:
                    SpacingRow(spacing: 20, isSpacingHeadTale: true, children: [
                  ...(state is TourListStateSuccess
                          ? tourListBloc.tourList.data
                          : List.generate(5, (index) => null))
                      .map(
                        (e) => TourItem(tour: e, showFriend: showFriend),
                      )
                      .toList(),
                  if (state is TourListStateSuccess &&
                      tourListBloc.tourList.canLoadmore)
                    ViewMoreButton(
                      onPressed: () {
                        showErrorMessage(Strings.common.developingFeature);
                      },
                      width: 120,
                    )
                ]),
              ),
            );
          }),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/app.dart';
import 'package:ginkgo_mobile/src/blocs/currentUser/current_user_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/userTour/user_tour_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/navigators.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/homeProvider.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/commonOutlineButton.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/errorIndicator.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/tourWidgets/borderTourItem.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:base/base.dart';

class TourListWidget extends StatefulWidget {
  final SimpleUser user;

  const TourListWidget({Key key, this.user}) : super(key: key);

  @override
  _TourListWidgetState createState() => _TourListWidgetState();
}

class _TourListWidgetState extends State<TourListWidget>
    with LoadDataWidgetMixin {
  final UserTourBloc _bloc = UserTourBloc();
  bool isCurrentUser = false;

  @override
  void initState() {
    super.initState();
    isCurrentUser = CurrentUserBloc().isCurrentUser(simpleUser: widget.user);
    loadData();
  }

  @override
  loadData() {
    _bloc.add(
      UserTourEventFetch(isCurrentUser ? 0 : widget.user?.id),
    );
  }

  viewAll() {
    if (isCurrentUser) {
      final homeProvider = HomeProvider.of(context);
      if (homeProvider != null) {
        homeProvider.tabController.animateTo(1);
      } else {
        Navigator.of(context).pushNamed(ProfileRoutes.manageTour);
      }
    } else {
      Navigators.appNavigator.currentState.pushNamed(Routes.profileTourList);
    }
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      icon: Assets.icons.tour,
      title: 'Các chuyến đi',
      childPadding: EdgeInsets.only(bottom: 10),
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is UserTourFailure) {
            completeLoadData();
            return ErrorIndicator(
              moreErrorDetail: state.error,
              onReload: loadData,
            );
          }

          completeLoadData();
          return Column(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: IntrinsicHeight(
                  child: SpacingRow(
                    spacing: 10,
                    children: state is UserTourSuccess
                        ? state.tours.data
                            .map((e) => BorderTourItem(tour: e))
                            .toList()
                        : List.generate(3, (i) {
                            return BorderTourItem();
                          }),
                  ),
                ),
              ),
              if (state is UserTourSuccess)
                if (state.tours.data.length > 0) ...[
                  const SizedBox(height: 20),
                  CommonOutlineButton(
                    text: 'Xem tất cả các chuyến đi',
                    onPressed: viewAll,
                  ),
                ] else
                  Text(
                    Strings.noData.tours,
                    style: context.textTheme.bodyText2
                        .copyWith(color: context.colorScheme.onSurface),
                  )
            ],
          );
        },
      ),
    );
  }
}

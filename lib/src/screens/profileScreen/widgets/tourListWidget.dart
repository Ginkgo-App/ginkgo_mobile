import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/userTour/user_tour_bloc.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/commonOutlineButton.dart';
import 'package:ginkgo_mobile/src/widgets/indicators/errorIndicator.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/tourWidgets/borderTourItem.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:base/base.dart';

class TourListWidget extends StatefulWidget {
  /// [UserId] = 0 is current user;
  final int userId;

  const TourListWidget({Key key, this.userId}) : super(key: key);

  @override
  _TourListWidgetState createState() => _TourListWidgetState();
}

class _TourListWidgetState extends State<TourListWidget> {
  final UserTourBloc _bloc = UserTourBloc();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() {
    _bloc.add(UserTourEventFetch(widget.userId));
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
            return ErrorIndicator(
              moreErrorDetail: state.error,
              onReload: _fetchData,
            );
          }
          return Column(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: IntrinsicHeight(
                  child: SpacingRow(
                    spacing: 10,
                    children: state is UserTourSuccess
                        ? state.tours
                            .map((e) => BorderTourItem(tour: e))
                            .toList()
                        : List.generate(3, (i) {
                            return BorderTourItem();
                          }),
                  ),
                ),
              ),
              if (state is UserTourSuccess)
                if (state.tours.length > 0) ...[
                  const SizedBox(height: 20),
                  CommonOutlineButton(
                    text: 'Xem tất cả các chuyến đi',
                    onPressed: () {},
                  ),
                ] else
                  Text(
                    Strings.noData.tours,
                    style: context.textTheme.body1
                        .copyWith(color: context.colorScheme.onSurface),
                  )
            ],
          );
        },
      ),
    );
  }
}

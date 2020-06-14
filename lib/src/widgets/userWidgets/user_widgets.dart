library user_widgets;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/app.dart';
import 'package:ginkgo_mobile/src/blocs/currentUser/current_user_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/navigators.dart';
import 'package:ginkgo_mobile/src/screens/screens.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:base/base.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/friend_buttons/friend_buttons.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

part 'circle_user.dart';
part 'circle_tour_user.dart';
part 'user_friend.dart';
part 'rect_radius_user.dart';

_navigateToUserScreen(SimpleUser user) {
  if (!CurrentUserBloc().isCurrentUser(simpleUser: user)) {
    Navigators.appNavigator.currentState
        .pushNamed(Routes.user, arguments: UserScreenArgs(user));
  } else {
    debugPrint('Cannot navigate because this is current user.');
  }
}

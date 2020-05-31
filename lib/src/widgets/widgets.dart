library widget;

import 'dart:async';
import 'dart:ui' show lerpDouble;

import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/gradientColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/friend_buttons/friend_buttons.dart';
import 'package:shimmer/shimmer.dart';

part 'addCommentWidget.dart';
part 'appBars/backAppBar.dart';
part 'avatar.dart';
part 'buttons/primaryButton.dart';
part 'containers/borderContainer.dart';
part 'containers/collapse_container.dart';
part 'customs/image_widget.dart';
part 'gradientTextFormField.dart';
part 'gradientUnderlineBorder.dart';
part 'hiddenText.dart';
part 'loadingDotIndicator.dart';
part 'loadingIndicator.dart';
part 'primaryScaffold.dart';
part 'skeleton.dart';
part 'userWidgets/circleTourUser.dart';
part 'userWidgets/circleUser.dart';
part 'userWidgets/user_friend.dart';

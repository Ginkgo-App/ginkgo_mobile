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
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/gradientColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';

part 'appBars/backAppBar.dart';
part 'borderContainer.dart';
part 'buttons/primaryButton.dart';
part 'gradientTextFormField.dart';
part 'gradientUnderlineBorder.dart';
part 'hiddenText.dart';
part 'loadingDotIndicator.dart';
part 'loadingIndicator.dart';
part 'addCommentWidget.dart';
part 'primaryScaffold.dart';
part 'avatar.dart';

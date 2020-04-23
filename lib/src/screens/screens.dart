library screens;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ginkgo_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/authScreen/auth_screen_bloc.dart';
import 'package:ginkgo_mobile/src/helper/convertLargeNumber.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/models/user.dart';
import 'package:ginkgo_mobile/src/screens/profileScreen/widgets/avatarWidget.dart';
import 'package:ginkgo_mobile/src/utils/gradientColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/utils/validator.dart';
import 'package:ginkgo_mobile/src/widgets/logoWidget.dart';
import 'package:ginkgo_mobile/src/widgets/particle/particles.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:toast/toast.dart';

import '../app.dart';

part 'homeScreen/homeScreen.dart';
part 'loginScreen/loginScreen.dart';
part 'registerScreen/registerScreen.dart';
part 'splashScreen/splashScreen.dart';
part 'profileScreen/profileScreen.dart';
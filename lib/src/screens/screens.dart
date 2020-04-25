library screens;

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/authScreen/auth_screen_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/models/user.dart';
import 'package:ginkgo_mobile/src/screens/profileScreen/widgets/avatarWidget.dart';
import 'package:ginkgo_mobile/src/screens/profileScreen/widgets/infoBox.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/utils/validator.dart';
import 'package:ginkgo_mobile/src/widgets/logoWidget.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:toast/toast.dart';

import '../app.dart';

part 'homeScreen/homeScreen.dart';
part 'loginScreen/loginScreen.dart';
part 'profileScreen/profileScreen.dart';
part 'registerScreen/registerScreen.dart';
part 'splashScreen/splashScreen.dart';
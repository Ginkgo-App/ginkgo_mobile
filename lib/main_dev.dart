import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/vi_time_ago_message.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'src/app.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Ginkgo Development',
    flavorName: AppFlavor.DEVELOPMENT,
    apiUrl: 'https://micro-api-core.herokuapp.com/api/v1',
    child: App(),
  );

  timeago.setLocaleMessages('vi', ViMessages());
  BlocSupervisor.delegate = BlocLogger();
  objectMapping();
  runApp(configuredApp);
}

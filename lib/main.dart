import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'src/app.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Ginkgo Production',
    flavorName: AppFlavor.PRODUCTION,
    apiUrl: 'https://micro-api-core.herokuapp.com/api/v1',
    child: App(),
  );

  timeago.setLocaleMessages('vi', timeago.ViMessages());
  objectMapping();
  runApp(configuredApp);
}

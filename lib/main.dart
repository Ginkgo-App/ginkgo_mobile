import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';

import 'src/app.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Ginkgo Production',
    flavorName: AppFlavor.PRODUCTION,
    apiUrl: 'https://micro-api-core.herokuapp.com/api/v1',
    child: App(),
  );

  objectMapping();
  runApp(configuredApp);
}

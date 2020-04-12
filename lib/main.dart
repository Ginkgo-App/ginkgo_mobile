import 'package:base/base.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Ginkgo Production',
    flavorName: AppFlavor.PRODUCTION,
    apiUrl: 'https://minpachi.com',
    child: App(),
  );

  runApp(configuredApp);
}

import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Ginkgo Development',
    flavorName: AppFlavor.DEVELOPMENT,
    apiUrl: 'https://abc.dev',
    child: App(),
  );

  BlocSupervisor.delegate = BlocLogger();
  runApp(configuredApp);
}

library app;

import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/screens/chat_list_screen/chat_list_screen.dart';
import 'package:ginkgo_mobile/src/screens/message_screen/message_screen.dart';
import 'package:ginkgo_mobile/src/screens/screens.dart';

import 'screens/screens.dart';

part 'routes/profileRoutes.dart';
part 'routes/routes.dart';

class App extends AppBase {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Ginkgo',
        initialRoute: Routes.splash,
        onGenerateRoute: _onGenerateRoute,
        navigatorKey: AppConfig.navigatorKey,
        theme: ThemeData(
          primaryColor: Color(0xffFF0000),
          colorScheme: ColorScheme(
            primary: Color(0xffFF0000),
            primaryVariant: Color(0xffFADBD4),
            secondary: Color(0xff4774d3),
            secondaryVariant: Color(0xffffa200),
            brightness: Brightness.light,
            error: Colors.red,
            onBackground: Color(0xff000000),
            onError: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Color(0xff7f7f7f),
            surface: Color(0xffE5E5E5),
            background: Color(0xffF9FAFB),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

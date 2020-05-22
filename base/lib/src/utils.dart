part of base;

ColorScheme get colorScheme =>
    Theme.of(AppConfig.globalKey.currentContext).colorScheme;

TextTheme get textTheme =>
    Theme.of(AppConfig.globalKey.currentContext).textTheme;

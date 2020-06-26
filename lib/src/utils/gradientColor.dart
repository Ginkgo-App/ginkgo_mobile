import 'package:flutter/material.dart';

class GradientColor {
  final BuildContext context;

  GradientColor.of(this.context);
  get primaryGradient => LinearGradient(
    colors: <Color>[
      Theme.of(context).primaryColor,
      Theme.of(context).colorScheme.primaryVariant,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  get primaryDisbleGradient => LinearGradient(
    colors: <Color>[
      Color(0xffFFAC9A),
      Color(0xffFFECE8),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  get backgroundGradient => LinearGradient(
    colors: <Color>[
      Color(0xffFEEEEB),
      Colors.white,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  get whiteBottomGradient => LinearGradient(
    colors: <Color>[
      Colors.white.withOpacity(0),
      Colors.white,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  get blogIcon => LinearGradient(
    colors: <Color>[
      Color(0xffFDC70C),
      Color(0xffF3903F),
      Color(0xffED683C),
      Color(0xffE93E3A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
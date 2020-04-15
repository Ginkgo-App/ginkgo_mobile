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
}
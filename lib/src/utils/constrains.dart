import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';

class Constains {
  static const DEFAULT_PAGE_SIZE = 10;

  static Widget defaultImage = Image.asset(
    Assets.images.defaultImage,
    fit: BoxFit.cover,
  );
}

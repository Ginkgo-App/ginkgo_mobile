import 'package:flutter/material.dart';

import 'models.dart';

class TourInfo {
  final int id;
  final String name;
  final List<String> images;
  final User createBy;

  TourInfo(
      {@required this.createBy,
      @required this.id,
      @required this.name,
      @required this.images});
}

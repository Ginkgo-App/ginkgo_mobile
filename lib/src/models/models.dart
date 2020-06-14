library models;

import 'dart:io';

import 'package:base/base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:path_provider/path_provider.dart';

export 'fakeData.dart';

part 'authResponse.dart';
part 'comment.dart';
part 'key_value.dart';
part 'multi_size_image.dart';
part 'pagination.dart';
part 'place.dart';
part 'post.dart';
part 'review.dart';
part 'socialProvider.dart';
part 'timeline.dart';
part 'timeline_detail.dart';
part 'tour.dart';
part 'tourInfo.dart';
part 'transform.dart';
part 'user.dart';
part 'file_asset.dart';

objectMapping() {
  Mappable.factories = {
    _PaginationDetail: () => _PaginationDetail(),
    AuthResponse: () => AuthResponse(),
    User: () => User(),
    SimpleUser: () => SimpleUser(),
    Tour: () => Tour(),
    TourInfo: () => TourInfo(),
    SimpleTour: () => SimpleTour(),
    Place: () => Place(),
  };
}

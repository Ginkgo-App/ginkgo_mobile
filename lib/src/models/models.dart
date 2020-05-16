export 'fakeData.dart';
export 'user.dart';

import 'package:ginkgo_mobile/src/models/authResponse.dart';
import 'package:ginkgo_mobile/src/models/place.dart';
import 'package:ginkgo_mobile/src/models/tour.dart';
import 'package:ginkgo_mobile/src/models/user.dart';
import 'package:object_mapper/object_mapper.dart';

objectMapping() {
  Mappable.factories = {
    AuthResponse: () => AuthResponse(),
    User: () => User(),
    SimpleUser: () => SimpleUser(),
    SimpleTour: () => SimpleTour(),
    Place: () => Place,
  };
}

export 'fakeData.dart';
export 'user.dart';

import 'package:ginkgo_mobile/src/models/authResponse.dart';
import 'package:object_mapper/object_mapper.dart';

objectMapping() {
  Mappable.factories = {
    AuthResponse: () => AuthResponse(),
  };
}

import 'package:ginkgo_mobile/src/models/user.dart';
import 'package:object_mapper/object_mapper.dart';

class SimpleTour with Mappable {
  int id;
  String name;
  DateTime startDay;
  DateTime endDay;
  int totalMember;
  List<String> images;
  SimpleUser host;

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map('StartDay', startDay, (v) => startDay = v);
    map('EndDay', endDay, (v) => endDay = v);
    map('TotalMember', totalMember, (v) => totalMember = v);
    map('Host', host, (v) => host = v);
    map<String>('Images', images, (v) => images = v);
  }
}

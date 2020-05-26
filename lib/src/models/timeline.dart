import 'package:ginkgo_mobile/src/models/date_time_transform.dart';
import 'package:ginkgo_mobile/src/models/timeline_detail.dart';
import 'package:object_mapper/object_mapper.dart';

class Timeline with Mappable {
  int id;
  DateTime day;
  String descrirption;
  List<TimelineDetail> timelineDetails;

  Timeline({this.id, this.day, this.descrirption, this.timelineDetails});

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Day', day, (v) => day = v, DateTimeTransform());
    map('Description', descrirption, (v) => descrirption = v);
    map<Timeline>(
        'TimelineDetails', timelineDetails, (v) => timelineDetails = v);
  }
}

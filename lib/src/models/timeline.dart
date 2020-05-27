part of 'models.dart';

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

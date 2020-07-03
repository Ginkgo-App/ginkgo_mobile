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
    map<TimelineDetail>(
        'TimelineDetails', timelineDetails, (v) => timelineDetails = v);
  }
}

class TimelineToPost with Mappable {
  DateTime day;
  String descrirption;
  List<TimelineDetailToPost> timelineDetails;

  TimelineToPost({this.day, this.descrirption, this.timelineDetails});

  @override
  void mapping(Mapper map) {
    map('Day', day, (v) => day = v, DateTimeTransform());
    map('Description', descrirption, (v) => descrirption = v);
    map<TimelineDetailToPost>(
        'TimelineDetails', timelineDetails, (v) => timelineDetails = v);
  }
}

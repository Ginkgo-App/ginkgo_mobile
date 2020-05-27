part of 'models.dart';

class TimelineDetail with Mappable {
  int id;
  Place place;
  String time;
  String detail;

  TimelineDetail({this.id, this.place, this.time, this.detail});

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Place', place, (v) => place = v);
    map('Time', time, (v) => time = v);
    map('Detail', detail, (v) => detail = v);
  }
}

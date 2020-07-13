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
    map('Place', place,
        (v) => place = v != null ? Mapper.fromJson(v).toObject<Place>() : null);
    map('Time', time, (v) => time = v);
    map('Detail', detail, (v) => detail = v);
  }
}

class TimelineDetailToPost with Mappable {
  Place place;
  String time;
  String detail;

  TimelineDetailToPost({this.place, this.time, this.detail});

  @override
  void mapping(Mapper map) {
    map('PlaceId', place?.id, (v) => place?.id = v);
    map('Time', time, (v) => time = v);
    map('Detail', detail, (v) => detail = v);
  }

  @override
  String toString() =>
      '$time: ${detail.replaceAll("{{place}}", place?.name ?? "")}';
}

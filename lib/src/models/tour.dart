import 'package:ginkgo_mobile/src/models/multi_size_image.dart';
import 'package:ginkgo_mobile/src/models/place.dart';
import 'package:ginkgo_mobile/src/models/timeline.dart';
import 'package:ginkgo_mobile/src/models/tourInfo.dart';
import 'package:ginkgo_mobile/src/models/transform.dart';
import 'package:ginkgo_mobile/src/models/user.dart';
import 'package:object_mapper/object_mapper.dart';

class Tour with Mappable {
  int id;
  String name;
  DateTime startDay;
  DateTime endDay;
  Place startPlace;
  Place destinatePlace;
  int totalMember;
  List<MultiSizeImage> images;
  SimpleUser host;
  double price;
  TourInfo tourInfo;
  List<Timeline> timelines;

  Tour(
      {this.id,
      this.name,
      this.startDay,
      this.endDay,
      this.startPlace,
      this.destinatePlace,
      this.totalMember,
      this.images,
      this.host,
      this.price,
      this.tourInfo,
      this.timelines});

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map('StartDay', startDay, (v) => startDay = v, DateTimeTransform());
    map('EndDay', endDay, (v) => endDay = v, DateTimeTransform());
    map('StartPlace', startPlace, (v) => startPlace = v);
    map('DestinatePlace', destinatePlace, (v) => destinatePlace = v);
    map('TotalMember', totalMember, (v) => totalMember = v);
    map('Host', host, (v) => host = v);
    map<MultiSizeImage>(
        'Images', images, (v) => images = v, MultiSizeImageTransform());
    map('Price', price, (v) => price = v);
    map('TourInfo', tourInfo, (v) => tourInfo = v);
  }
}

class SimpleTour with Mappable {
  int id;
  String name;
  DateTime startDay;
  DateTime endDay;
  int totalMember;
  List<MultiSizeImage> images;
  SimpleUser host;
  double price;
  double rating;
  SimpleUser friend;

  SimpleTour(
      {this.id,
      this.name,
      this.startDay,
      this.endDay,
      this.totalMember,
      this.images,
      this.host,
      this.price,
      this.rating,
      this.friend});

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map('StartDay', startDay, (v) => startDay = v, DateTimeTransform());
    map('EndDay', endDay, (v) => endDay = v, DateTimeTransform());
    map('TotalMember', totalMember, (v) => totalMember = v);
    map('Host', host, (v) => host = v);
    map<MultiSizeImage>(
        'Images', images, (v) => images = v, MultiSizeImageTransform());
    map('Price', price, (v) => price = v);
    map('Rating', rating, (v) => rating = v);
    map('Friend', friend, (v) => friend = v);
  }
}

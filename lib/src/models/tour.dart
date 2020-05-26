import 'package:ginkgo_mobile/src/models/multi_size_image.dart';
import 'package:ginkgo_mobile/src/models/user.dart';
import 'package:object_mapper/object_mapper.dart';

class SimpleTour with Mappable {
  int id;
  String name;
  DateTime startDay;
  DateTime endDay;
  int totalMember;
  List<MultiSizeImage> images;
  SimpleUser host;
  double price;
  int rating;
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
    map('StartDay', startDay, (v) => startDay = v);
    map('EndDay', endDay, (v) => endDay = v);
    map('TotalMember', totalMember, (v) => totalMember = v);
    map('Host', host, (v) => host = v);
    map<String>('Images', images, (v) => images = v);
    map('Price', price, (v) => price = v);
    map('Rating', rating, (v) => rating = v);
    map('Friend', friend, (v) => friend = v);
  }
}

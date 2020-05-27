part of 'models.dart';

class Place with Mappable {
  int id;
  String name;
  List<String> images;
  String description;
  int tourCount;

  Place({this.id, this.name, this.images, this.description, this.tourCount});

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map<String>('Images', images, (v) => images = v);
    map('Description', description, (v) => description = v);
    map('TourCount', tourCount, (v) => tourCount = v);
  }
}

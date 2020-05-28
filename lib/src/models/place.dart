part of 'models.dart';

class Place with Mappable {
  int id;
  String name;
  List<MultiSizeImage> images;
  String description;
  int tourCount;
  SimpleUser createBy;

  Place(
      {this.id,
      this.name,
      this.images,
      this.description,
      this.tourCount,
      this.createBy});

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map<MultiSizeImage>(
        'Images', images, (v) => images = v, MultiSizeImageTransform());
    map('Description', description, (v) => description = v);
    map('TourCount', tourCount, (v) => tourCount = v);
    map('CreateBy', createBy, (v) => createBy = v);
  }
}

enum PlaceSearchType { city, other }

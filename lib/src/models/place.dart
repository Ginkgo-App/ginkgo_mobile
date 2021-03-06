part of 'models.dart';

class Place with Mappable {
  int id;
  String name;
  String address;
  List<MultiSizeImage> images = [];
  String description;
  int tourCount;
  SimpleUser createBy;
  KeyValue type;
  List<Place> children;

  Place({
    this.id,
    this.name,
    this.address,
    this.images,
    this.description,
    this.tourCount,
    this.createBy,
    this.type,
    this.children,
  });

  Map<KeyValue, List<Place>> childrenMap() {
    Map<KeyValue, List<Place>> result = {};

    if (children != null && children.length > 0) {
      children.forEach((element) {
        if (element.type != null) {
          if (result[element.type] == null) {
            result[element.type] = [];
          }
          result[element.type].add(element);
        }
      });
    }

    return result;
  }

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map<MultiSizeImage>('Images', images, (v) {
      images = v;
      images.shuffle();
    }, MultiSizeImageTransform());
    map('Address', address, (v) => address = v);
    map('Description', description, (v) => description = v);
    map('TourCount', tourCount, (v) => tourCount = v);
    map('CreateBy', createBy, (v) => createBy = v);
    map(
        'Type',
        type,
        (v) => type = v != null
            ? KeyValue(key: v['Id'].toString(), value: v['Value'])
            : null);
    map<Place>('ChildPlaces', children, (v) => children = v);
  }
}

enum PlaceSearchType { city, other }

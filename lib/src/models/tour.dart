part of 'models.dart';

enum MeTourType { owner, member, all }

enum TourListType { recommend, friend, forYou }

enum TourMembersType { accepted, requesting }

class Tour with Mappable {
  int id;
  String name;
  double rating;
  DateTime startDay;
  DateTime endDay;
  int totalDay;
  int totalNight;
  int totalMember;
  int maxMember;
  List<String> services;
  SimpleUser createBy;
  double price;
  List<Timeline> timelines;
  TourInfo tourInfo;
  DateTime joinAt;
  DateTime acceptedAt;

  List<MultiSizeImage> get images => tourInfo?.images ?? [];

  Tour({
    this.id,
    this.name,
    this.rating,
    this.startDay,
    this.endDay,
    this.totalDay,
    this.totalNight,
    this.totalMember,
    this.maxMember,
    this.services,
    this.createBy,
    this.price,
    this.timelines,
    this.tourInfo,
    this.joinAt,
    this.acceptedAt,
  });

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map('Rating', rating, (v) => rating = v);
    map('StartDay', startDay, (v) => startDay = v, DateTimeTransform());
    map('EndDay', endDay, (v) => endDay = v, DateTimeTransform());
    map('TotalDay', totalDay, (v) => totalDay = v);
    map('TotalNight', totalNight, (v) => totalNight = v);
    map('TotalMember', totalMember, (v) => totalMember = v);
    map('MaxMember', maxMember, (v) => maxMember = v);
    map<Timeline>('TimeLines', timelines, (v) => timelines = v);
    map<String>('Services', services, (v) => services = v);
    map('TourInfo', tourInfo,
        (v) => tourInfo = Mapper.fromJson(v).toObject<TourInfo>());
    map('Createby', createBy,
        (v) => createBy = Mapper.fromJson(v).toObject<SimpleUser>());
    map('JoinAt', joinAt, (v) => joinAt = v, DateTimeTransform());
    map('AcceptedAt', acceptedAt, (v) => acceptedAt = v, DateTimeTransform());
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
  List<SimpleUser> friends;

  SimpleTour({
    this.id,
    this.name,
    this.startDay,
    this.endDay,
    this.totalMember,
    this.images,
    this.host,
    this.price,
    this.rating,
    this.friends,
  });

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map('StartDay', startDay, (v) => startDay = v, DateTimeTransform());
    map('EndDay', endDay, (v) => endDay = v, DateTimeTransform());
    map('TotalMember', totalMember, (v) => totalMember = v);
    map('Host', host, (v) => host = Mapper.fromJson(v).toObject<SimpleUser>());
    map<MultiSizeImage>('Images', images, (v) {
      images = v;
      images?.shuffle();
    }, MultiSizeImageTransform());
    map('Price', price, (v) => price = v);
    map('Rating', rating, (v) => rating = v);
    map<SimpleUser>('Friend', friends, (v) => friends = v);
  }
}

class TourToPost with Mappable {
  String name;
  DateTime startDay;
  DateTime endDay;
  int totalDay;
  int totalNight;
  int maxMember;
  double price;
  int tourInfoId;
  List<TimelineToPost> timelines;
  List<String> services;

  TourToPost(
      {this.name,
      this.startDay,
      this.endDay,
      this.totalDay,
      this.totalNight,
      this.maxMember,
      this.price,
      this.tourInfoId,
      this.timelines,
      this.services});

  @override
  void mapping(Mapper map) {
    map('Name', name, (v) => name = v);
    map('StartDay', startDay, (v) => startDay = v, DateTimeTransform());
    map('EndDay', endDay, (v) => endDay = v, DateTimeTransform());
    map('TotalDay', totalDay, (v) => totalDay = v);
    map('TotalNight', totalNight, (v) => totalNight = v);
    map('MaxMember', maxMember, (v) => maxMember = v);
    map<TimelineToPost>('Timelines', timelines, (v) => timelines = v);
    map('Services', services, (v) => services = v);
    map('Price', price, (v) => price = v);
    map('TourInfoId', tourInfoId, (v) => tourInfoId = v);
  }

  void update(TourToPost t) {
    name = t.name ?? name;
    startDay = t.startDay ?? startDay;
    endDay = t.endDay ?? endDay;
    totalDay = t.totalDay ?? totalDay;
    totalNight = t.totalNight ?? totalNight;
    maxMember = t.maxMember ?? maxMember;
    price = t.price ?? price;
    tourInfoId = t.tourInfoId ?? tourInfoId;
    timelines = t.timelines ?? timelines;
    services = t.services ?? services;
  }
}

class TotalDayNight {
  final int totalDay;
  final int totalNight;
  final int type;

  TotalDayNight(
      {@required this.totalDay, @required this.totalNight, this.type = 1});

  ///
  /// [type = 1] totalDay = dayDifferent, endDay = dayDifferent
  /// [type = 2] totalDay = dayDifferent - 1, endDay = dayDifferent
  /// [type = 3] totalDay = dayDifferent, endDay = dayDifferent - 1
  /// [type = 4] totalDay = dayDifferent - 1, endDay = dayDifferent - 1
  factory TotalDayNight.fromDayTime(DateTime startDay, DateTime endDay,
      [int type = 1]) {
    if (startDay == null || endDay == null) return null;

    final dayDifferent = endDay.difference(startDay).inDays;

    if (type == 2) {
      return TotalDayNight(
          totalDay: dayDifferent - 1, totalNight: dayDifferent, type: type);
    } else if (type == 3) {
      return TotalDayNight(
          totalDay: dayDifferent, totalNight: dayDifferent - 1, type: type);
    } else if (type == 4) {
      return TotalDayNight(
          totalDay: dayDifferent - 1, totalNight: dayDifferent - 1, type: type);
    }
    return TotalDayNight(
        totalDay: dayDifferent, totalNight: dayDifferent, type: type);
  }

  @override
  String toString() =>
      '${totalDay > 0 ? '$totalDay ngày ' : ''}${totalNight > 0 ? '$totalNight đêm' : ''}';
}

class TourMember extends SimpleUser with Mappable {
  DateTime joinAt;
  DateTime acceptedAt;

  TourMember({
    int id,
    String name,
    MultiSizeImage avatar,
    String job,
    int tourCount,
    FriendType friendType,
    this.joinAt,
    this.acceptedAt,
  }) : super(
          id: id,
          name: name,
          avatar: avatar,
          job: job,
          tourCount: tourCount,
          friendType: friendType,
        );

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('JoinAt', joinAt, (v) => joinAt = v, DateTimeTransform());
    map('AcceptedAt', acceptedAt, (v) => acceptedAt = v, DateTimeTransform());
  }
}

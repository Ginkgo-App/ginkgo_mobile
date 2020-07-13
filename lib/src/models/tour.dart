part of 'models.dart';

enum MeTourType { owner, member, all }

enum TourListType { recommend, friend, forYou }

enum TourMemberType { accepted, requesting, none }

enum TourStatus { coming, ongoing, ended }

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

  bool isHost(SimpleUser user) =>
      user == null ? false : user?.id == createBy?.id;

  bool canJoin(SimpleUser user) =>
      !isHost(user) &&
      joinAt == null &&
      acceptedAt == null &&
      status == TourStatus.coming;

  bool canReview(SimpleUser user) {
    return !isHost(user) &&
        joinAt != null &&
        acceptedAt != null &&
        status == TourStatus.ended;
  }

  SimpleTour toSimpleTour() => SimpleTour(
        id: id,
        endDay: endDay,
        friends: [],
        host: createBy,
        images: tourInfo?.images ?? [],
        name: name,
        price: price,
        rating: rating,
        startDay: startDay,
        totalMember: totalMember,
      );

  TourStatus get status {
    final now = DateTime.now();
    if (now.compareTo(startDay) < 0) {
      return TourStatus.coming;
    } else if (now.compareTo(endDay) > 0) {
      return TourStatus.ended;
    } else {
      return TourStatus.ongoing;
    }
  }

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
    map('Services', services,
        (v) => services = (v as List).map((e) => e.toString()).toList());
    map('TourInfo', tourInfo,
        (v) => tourInfo = Mapper.fromJson(v).toObject<TourInfo>());
    map(
        'CreateBy',
        createBy,
        (v) => createBy =
            v != null ? Mapper.fromJson(v).toObject<SimpleUser>() : null);
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
  List<MultiSizeImage> _images;
  SimpleUser host;
  double price;
  int totalDay;
  int totalNight;
  double rating;
  List<SimpleUser> friends;
  TourInfo tourInfo;

  List<MultiSizeImage> get images => _images ?? tourInfo?.images ?? [];

  SimpleTour({
    this.id,
    this.name,
    this.startDay,
    this.endDay,
    this.totalMember,
    List<MultiSizeImage> images,
    this.host,
    this.price,
    this.totalDay,
    this.totalNight,
    this.rating,
    this.friends,
  }) : _images = images;

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map('StartDay', startDay, (v) => startDay = v, DateTimeTransform());
    map('EndDay', endDay, (v) => endDay = v, DateTimeTransform());
    map('TotalMember', totalMember, (v) => totalMember = v);
    map('Host', host, (v) => host = Mapper.fromJson(v).toObject<SimpleUser>());
    map<MultiSizeImage>('Images', _images, (v) {
      _images = v;
      _images?.shuffle();
    }, MultiSizeImageTransform());
    map('Price', price, (v) => price = v);
    map('Rating', rating, (v) => rating = v);
    map('TotalDay', totalDay, (v) => totalDay = v);
    map('TotalNight', totalNight, (v) => totalNight = v);
    map<SimpleUser>('Friends', friends, (v) => friends = v);
    map(
        'TourInfo',
        tourInfo,
        (v) => tourInfo =
            v != null ? Mapper.fromJson(v).toObject<TourInfo>() : null);
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
      '${totalDay != null && totalDay > 0 ? '$totalDay ngày ' : ''}${totalNight != null && totalNight > 0 ? '$totalNight đêm' : ''}';
}

class TourMember extends SimpleUser with Mappable {
  DateTime joinAt;
  DateTime acceptedAt;

  TourMemberType get type => joinAt != null && acceptedAt != null
      ? TourMemberType.accepted
      : (joinAt != null ? TourMemberType.requesting : TourMemberType.none);

  bool get isMember => joinAt != null && acceptedAt != null;

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

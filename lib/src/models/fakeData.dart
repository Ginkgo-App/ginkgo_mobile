import 'package:base/base.dart';

import 'models.dart';

class FakeData {
  static final Notification notification = Notification(
      id: 1,
      message: 'Bạn vừa nhận một tin nhắn mới từ',
      type: 1,
      readAt: DateTime(2020, 11, 6, 3, 30),
      createdAt: DateTime(2020, 1, 5),
      payload: 'Nguyen');

  static final SimpleTour simpleTour = SimpleTour(
    id: 1,
    endDay: DateTime(2020, 1, 6),
    startDay: DateTime(2020, 1, 5),
    host: simpleUser,
    images: [
      MultiSizeImage(
          'https://image.bizlive.vn/uploaded/quynhntn/2018_11_28/dray-nur-1_fbjm.jpg'),
      MultiSizeImage(
          'https://images.unsplash.com/photo-1552458403-45c1a26d744c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
      MultiSizeImage(
          'https://images.unsplash.com/photo-1552524589-c76555c59289?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
      MultiSizeImage(
          'https://images.unsplash.com/photo-1552524589-c76555c59289?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
      MultiSizeImage(
          'https://images.unsplash.com/photo-1552524589-c76555c59289?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
    ],
    name: 'Tour khám phá Tây Nguyên',
    price: 10000,
    rating: 4,
    totalMember: 2,
    friends: [currentUser.toSimpleUser()],
  );

  static final SimpleUser simpleUser = SimpleUser(
      avatar: MultiSizeImage('https://i.imgur.com/ePEkVUYb.jpg'),
      id: 1,
      job: 'an khong ngoi roi',
      name: 'Ăn hại',
      tourCount: 15,
      friendType: FriendType.accepted);

  static final SimpleUser simpleUser2 = SimpleUser(
      avatar: MultiSizeImage('https://i.imgur.com/ePEkVUYb.jpg'),
      id: 1,
      job: 'Singer, Composer',
      name:
          'Requesting David Kevin Sergio Leroy Ederson Mahred Bernaldo Sterling',
      tourCount: 15,
      friendType: FriendType.requested);

  static final SimpleUser simpleUser3 = SimpleUser(
      avatar: MultiSizeImage('https://i.imgur.com/ePEkVUYb.jpg'),
      id: 1,
      job: 'Singer, Composer',
      name: 'Waiting Friend',
      tourCount: 15,
      friendType: FriendType.waiting);

  static final SimpleUser simpleUser4 = SimpleUser(
      avatar: MultiSizeImage('https://i.imgur.com/ePEkVUYb.jpg'),
      id: 1,
      job: 'Singer, Composer',
      name: 'Người lạ ơi',
      tourCount: 15,
      friendType: FriendType.none);

  static final User currentUser = User(
    phoneNumber: '+8499999999',
    email: 'sontung@gmail.com',
    fullName: 'Sơn Tùng MTP',
    job: 'Singer, Composer',
    birthday: DateTime(1998, 1, 1),
    gender: enumToString(Gender.other),
    slogan:
        'Nguyễn Thanh Tùng (sinh ngày 5 tháng 7 năm 1994) hay còn được biết đến với nghệ danh Sơn Tùng M-TP là một nam ca sĩ, nhạc sĩ và diễn viên người Việt Nam.',
    bio: '''
Nguyễn Thanh Tùng hay được biết đến với nghệ danh Sơn Tùng M-TP (sinh ngày 5 tháng 7 năm 1994) là một ca sĩ, nhạc sĩ và diễn viên người Việt Nam.
\nCác đĩa đơn năm 2012 và 2013 của anh, "Cơn mưa ngang qua" và "Em của ngày hôm qua" đã đánh dấu mốc khởi đầu cho sự nghiệp của anh. 
\nVào năm 2017, anh nhận được sự công nhận thiện chí hơn từ cộng đồng mạng sau khi phát hành hai đĩa đơn "Lạc trôi" và "Nơi này có anh". 
\nSơn Tùng cũng cho ra mắt album tổng hợp m-tp M-TP vào cùng năm và cuốn tự truyện Chạm tới giấc mơ. Tháng 7 năm 2019, anh phát hành đĩa đơn "Hãy trao cho anh" gây tiếng vang lớn và lập được nhiều kỷ lục, được truyền thông quốc tế đánh giá cao. Cũng trong năm 2019, anh tổ chức tour diễn xuyên Việt Sky Tour 2019 tại 3 thành phố Thành phố Hồ Chí Minh, Đà Nẵng và Hà Nội. 
    ''',
    avatar: MultiSizeImage('https://i.imgur.com/ePEkVUYb.jpg'),
    address: 'District 1, Ho Chi Minh',
    tourCount: 15,
  );

  static final Post post = Post(
    id: 1,
    author: currentUser.toSimpleUser(),
    content:
        '''Hôm nay có thời gian nên mình review chuyến đi Đà Nẵng, Hội An vừa qua của mình. Ta nói vui ơi là vui, ban tổ chức cực kỳ chu đáo, có xe đưa rước tận nơi, dịch vụ vui chơi thì khỏi chê vào đâu. Khách sạn sạch sẽ, đẹp,... bla bla bla bò bí bô la la la...
Nói chung là đáng đồng tiền bỏ ra. Nếu có dịp lần sau sẽ ủng hộ tiếp hihi...''',
    createAt: DateTime(2019, 1, 1, 12, 12),
    images: [
      MultiSizeImage(
          'https://images.unsplash.com/photo-1552702565-ed98c940b611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
      MultiSizeImage(
          'https://images.unsplash.com/photo-1552458403-45c1a26d744c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
      MultiSizeImage(
          'https://images.unsplash.com/photo-1552524589-c76555c59289?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
      MultiSizeImage(
          'https://images.unsplash.com/photo-1552524589-c76555c59289?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
      MultiSizeImage(
          'https://images.unsplash.com/photo-1552524589-c76555c59289?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
    ],
    featuredComment: Comment(
        id: 12, author: currentUser, content: 'Ôi ảnh đẹp quá bạn ơi...'),
    totalComment: 10,
    totalLike: 10,
  );

  static final Post postNoImage = Post(
    id: 1,
    author: currentUser.toSimpleUser(),
    content:
        '''Hôm nay có thời gian nên mình review chuyến đi Đà Nẵng, Hội An vừa qua của mình. Ta nói vui ơi là vui, ban tổ chức cực kỳ chu đáo, có xe đưa rước tận nơi, dịch vụ vui chơi thì khỏi chê vào đâu. Khách sạn sạch sẽ, đẹp,... bla bla bla bò bí bô la la la...
Nói chung là đáng đồng tiền bỏ ra. Nếu có dịp lần sau sẽ ủng hộ tiếp hihi...''',
    createAt: DateTime(2019, 1, 1, 12, 12),
    images: [],
    featuredComment: Comment(
        id: 12, author: currentUser, content: 'Ôi ảnh đẹp quá bạn ơi...'),
    totalComment: 10,
    totalLike: 10,
  );

  static final Post review = Post(
    id: 1,
    author: currentUser.toSimpleUser(),
    tour: simpleTour,
    content: '''Hôm nay có thời gian nên mình review chuyến đi Đà Nẵng, 
Hội An vừa qua của mình. Ta nói vui ơi là vui, 
ban tổ chức cực kỳ chu đáo, có xe đưa rước tận nơi,
dịch vụ vui chơi thì khỏi chê vào đâu. 
Khách sạn sạch sẽ, đẹp,... bla bla bla bò bí bô la la la...
Nói chung là đáng đồng tiền bỏ ra. Nếu có dịp lần sau sẽ ủng hộ tiếp hihi...''',
    createAt: DateTime(2019, 1, 1, 12, 12),
    featuredComment: Comment(
        id: 12, author: currentUser, content: 'Ôi ảnh đẹp quá bạn ơi...'),
    totalComment: 10,
    totalLike: 10,
    rating: 4,
  );

  static final TourInfo tourInfo = TourInfo(
      id: 1,
      name: 'Tour du lịch Hội An - Đà Nẵng',
      images: [
        MultiSizeImage(
            'https://images.unsplash.com/photo-1552702565-ed98c940b611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
        MultiSizeImage(
            'https://images.unsplash.com/photo-1552458403-45c1a26d744c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
        MultiSizeImage(
            'https://images.unsplash.com/photo-1552524589-c76555c59289?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
        MultiSizeImage(
            'https://images.unsplash.com/photo-1552524589-c76555c59289?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
        MultiSizeImage(
            'https://images.unsplash.com/photo-1552524589-c76555c59289?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80'),
      ],
      startPlace: place,
      destinatePlace: place,
      createBy: currentUser.toSimpleUser(),
      rating: 5);

  static final Tour tour = Tour(
      id: 1,
      name: 'Tour du lịch Hội An - Đà Nẵng',
      totalMember: 15,
      maxMember: 4,
      rating: 2,
      services: List.generate(10, (index) => 'This is a service.'),
      acceptedAt: DateTime(2020, 6, 6),
      joinAt: DateTime(2020, 6, 1),
      totalDay: 1,
      totalNight: 1,
      startDay: DateTime(2020, 10, 10),
      endDay: DateTime(2020, 10, 11),
      createBy: currentUser.toSimpleUser(),
      price: 500000,
      timelines: List.generate(10, (_) => timeline),
      tourInfo: tourInfo);

  static final Place place = Place(
      id: 1,
      name: 'My home',
      address: '133 Nguyễn Tất Thành, Pleiku, Gia Lai',
      images: [
        MultiSizeImage(
            'https://image.bizlive.vn/uploaded/quynhntn/2018_11_28/dray-nur-1_fbjm.jpg'),
        MultiSizeImage(
            'https://image.bizlive.vn/uploaded/quynhntn/2018_11_28/dray-nur-1_fbjm.jpg'),
      ],
      description: '',
      tourCount: 500,
      type: KeyValue(key: 'city', value: 'Thành phố'),
      createBy: currentUser.toSimpleUser(),
      children: List.generate(10, (index) => childPlace));

  static final Place childPlace = Place(
    id: 1,
    name: 'Ngọc Sê Hotel',
    address: '133 Nguyễn Tất Thành, Pleiku, Gia Lai',
    images: [
      MultiSizeImage(
          'https://image.bizlive.vn/uploaded/quynhntn/2018_11_28/dray-nur-1_fbjm.jpg'),
      MultiSizeImage(
          'https://image.bizlive.vn/uploaded/quynhntn/2018_11_28/dray-nur-1_fbjm.jpg'),
    ],
    description:
        'Khách sạn đạt chuẩn 5 sao, được nhiều khách du lịch tin tưởng và đánh giá tốt... Thêm vài câu mô tả ngắn gọn ở đâyKhách sạn đạt chuẩn 5 sao, được nhiều khách du lịch tin tưởng và đánh giá tốt.Khách sạn đạt chuẩn 5 sao, được nhiều khách du lịch tin tưởng và đánh giá tốt. Thêm vài câu mô tả ngắn gọn ở đây. Khách sạn đạt chuẩn 5 sao, được nhiều khách du lịch tin tưởng và đánh giá tốt.',
    tourCount: 500,
    type: KeyValue(key: 'city', value: 'Thành phố'),
    createBy: currentUser.toSimpleUser(),
  );

  static final Timeline timeline = Timeline(
      id: 1,
      day: DateTime.now(),
      descrirption: "Something",
      timelineDetails: List.generate(4, (_) => timelineDetail));

  static final TimelineDetail timelineDetail = TimelineDetail(
      id: 1,
      detail:
          'Ăn sáng, uống nước, xỉa răng, lau miệng, đi vệ sinh, tắm rửa, lướt face, nghe nhạc tại {{place}}. Lên đường!',
      place: place,
      time: '9h - 10h sáng');
}

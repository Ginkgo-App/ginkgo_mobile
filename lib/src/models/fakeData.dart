import 'package:ginkgo_mobile/src/models/user.dart';

class FakeData {
  static final User currentUser = User(
    phoneNumber: '+8499999999',
    email: 'sontung@gmail.com',
    fullName: 'Sơn Tùng MTP',
    job: 'Singer, Composer',
    birthday: DateTime(1998, 1, 1),
    gender: Gender.male,
    slogan: 'Nguyễn Thanh Tùng (sinh ngày 5 tháng 7 năm 1994) hay còn được biết đến với nghệ danh Sơn Tùng M-TP là một nam ca sĩ, nhạc sĩ và diễn viên người Việt Nam.',
    bio: '''
Nguyễn Thanh Tùng hay được biết đến với nghệ danh Sơn Tùng M-TP (sinh ngày 5 tháng 7 năm 1994) là một ca sĩ, nhạc sĩ và diễn viên người Việt Nam.
\nCác đĩa đơn năm 2012 và 2013 của anh, "Cơn mưa ngang qua" và "Em của ngày hôm qua" đã đánh dấu mốc khởi đầu cho sự nghiệp của anh. 
\nVào năm 2017, anh nhận được sự công nhận thiện chí hơn từ cộng đồng mạng sau khi phát hành hai đĩa đơn "Lạc trôi" và "Nơi này có anh". 
\nSơn Tùng cũng cho ra mắt album tổng hợp m-tp M-TP vào cùng năm và cuốn tự truyện Chạm tới giấc mơ. Tháng 7 năm 2019, anh phát hành đĩa đơn "Hãy trao cho anh" gây tiếng vang lớn và lập được nhiều kỷ lục, được truyền thông quốc tế đánh giá cao. Cũng trong năm 2019, anh tổ chức tour diễn xuyên Việt Sky Tour 2019 tại 3 thành phố Thành phố Hồ Chí Minh, Đà Nẵng và Hà Nội. 
    ''',
    avatar:
        'https://yt3.ggpht.com/a/AGF-l78QGTW3gMAN3s_devNGhlzjBO9eCRPGTg0iUQ=s900-c-k-c0xffffffff-no-rj-mo',
    address: 'District 1, Ho Chi Minh',
  );
}

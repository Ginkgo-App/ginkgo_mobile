import 'package:ginkgo_mobile/src/models/comment.dart';
import 'package:ginkgo_mobile/src/models/post.dart';
import 'package:ginkgo_mobile/src/models/user.dart';

class FakeData {
  static final User currentUser = User(
    phoneNumber: '+8499999999',
    email: 'sontung@gmail.com',
    fullName: 'Sơn Tùng MTP',
    job: 'Singer, Composer',
    birthday: DateTime(1998, 1, 1),
    gender: Gender.male,
    slogan:
        'Nguyễn Thanh Tùng (sinh ngày 5 tháng 7 năm 1994) hay còn được biết đến với nghệ danh Sơn Tùng M-TP là một nam ca sĩ, nhạc sĩ và diễn viên người Việt Nam.',
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

  static final Post post = Post(
    id: '1',
    author: currentUser,
    content:
        '''Hôm nay có thời gian nên mình review chuyến đi Đà Nẵng, Hội An vừa qua của mình. Ta nói vui ơi là vui, ban tổ chức cực kỳ chu đáo, có xe đưa rước tận nơi, dịch vụ vui chơi thì khỏi chê vào đâu. Khách sạn sạch sẽ, đẹp,... bla bla bla bò bí bô la la la...
Nói chung là đáng đồng tiền bỏ ra. Nếu có dịp lần sau sẽ ủng hộ tiếp hihi...''',
    createAt: DateTime(2019, 1, 1, 12, 12),
    images: [
      'https://images.unsplash.com/photo-1552702565-ed98c940b611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80',
      'https://images.unsplash.com/photo-1552458403-45c1a26d744c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80',
      'https://images.unsplash.com/photo-1552524589-c76555c59289?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=720&q=80',
    ],
    featuredComment: Comment(
        id: '12',
        postId: '1',
        author: currentUser,
        content: 'Ôi ảnh đẹp quá bạn ơi...'),
    totalComment: 10,
    totalLike: 10,
  );
}

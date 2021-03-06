class Strings {
  static final appTitle = 'Ginkgo';
  static final common = _Common();
  static final button = _Button();
  static final error = _Error();
  static final noData = _NoData();
  static final bottomNavigator = _BottomNavigator();
  static final loginScreen = _LoginScreen();
  static final registerScreen = _RegisterScreen();
  static final post = _Post();
  static final place = _Place();
  static final _MessageScreen messageScreen = _MessageScreen();
}

class _Common {
  final name = 'Họ tên';
  final email = 'Email';
  final phoneNumber = 'Số điện thoại';
  final password = 'Mật khẩu';
  final rePassword = 'Nhập lại mật khẩu';
  final developingFeature = 'Tính năng đang phát triển.';
}

class _Button {
  final login = 'Đăng nhập';
  final register = 'Đăng ký';
  final forgotPassword = 'Quên mật khẩu?';
  final logout = 'Đăng xuất';
  final reload = 'Tải lại';
  final takeAPicture = 'Chụp ảnh';
  final pickFromGallery = 'Chọn từ thư viện';
  final cancel = 'Hủy bỏ';
  final edit = 'Chỉnh sửa';
  final saveChanges = 'Lưu thay đổi';
  final viewAllImages = 'Xem tất cả hình ảnh';
  final viewAll = 'Xem tất cả';
  final takePartInNow = 'Tham gia ngay';
  final findFriendNow = 'Tìm bạn ngay';
  final nextStep = 'Sang bước tiếp theo';
  final backStep = 'Trở lại bước trước';
  final complete = 'Hoàn tất';
  final createTourNow = 'Tạo chuyến đi ngay';
}

class _Error {
  final emptyRequiredInput = 'Hãy điền thông tin vào trường bắt buộc.';
  final emailIncorrectForm = 'Email không đúng định dạng.';
  final phoneNumberIncorrectForm = 'Số điện thoại không đúng định dạng.';
  final rePasswordIsNotMatch = 'Re-password is not match with password.';
  final cannotRegisterWithFacebook = 'Không thể đăng ký bằng facebook';
  final errorClick = 'Đã xảy ra lỗi. Click để xem chi tiết.';
  final error = 'Đã xảy ra lỗi.';
  final updateProfile = 'Xảy ra lỗi trong khi cập nhật.';
  final updateBio = 'Xảy ra lỗi trong khi cập nhật tự giới thiệu.';
  final updateSolgan = 'Xảy ra lỗi trong khi cập nhật sologan.';
  final updateAvatar = 'Xảy ra lỗi trong khi cập nhật ảnh đại diện.';
  final unknowError = 'Lỗi không xác định';
}

class _NoData {
  final friends = 'Không có bạn bè';
  final tours = 'Không có chuyến đi';
}

class _BottomNavigator {
  final home = 'Trang chủ';
  final tour = 'Chuyến đi';
  final profile = 'Cá nhân';
  final notification = 'Thông báo';
  final setting = 'Cài đặt';
}

class _LoginScreen {
  final orLoginWith = 'Hoặc đăng nhập với';
  final doNotHaveAccount = 'Chưa có tài khoản?';
  final registerNow = 'Đăng ký ngay';
}

class _RegisterScreen {
  final title = 'Đăng ký tài khoản mới';
  final hadAccount = 'Đã có tài khoản? ';
  final loginNow = 'Đăng nhập ngay';
}

class _Post {
  String postAImage({bool isJust = false}) =>
      ' ${isJust ? 'vừa' : 'đã'} đăng một ảnh mới';
  String postImages({bool isJust = false}) =>
      ' ${isJust ? 'vừa' : 'đã'} đăng ảnh mới';
  String postAPost({bool isJust = false}) =>
      ' ${isJust ? 'vừa' : 'đã'} đăng bài viết mới';
  String createATour({bool isJust = false}) =>
      ' ${isJust ? 'vừa' : 'đã'} thêm một chuyến đi mới';
  String totalLike(int totalLike) => '$totalLike lượt yêu thích';
  String viewAllComment(int totalComment) =>
      'Xem tất cả $totalComment lượt bình luận';
  final addComment = 'Thêm bình luận';
  final reviewTitle = ' đã thêm một nhận xét mới cho ';
}

class _Place {
  String tourCount(int tourCount) => '$tourCount chuyến đi';
}

class _MessageScreen {
  final hint = 'Nhập tin nhắn';
  String lastOnlineAt(String time) => 'Truy cập $time';
}

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
}

class _Error {
  final emptyRequiredInput = 'Please enter something.';
  final emailIncorrectForm = 'Email không đúng định dạng.';
  final phoneNumberIncorrectForm = 'Số điện thoại không đúng định dạng.';
  final rePasswordIsNotMatch = 'Re-password is not match with password.';
  final cannotRegisterWithFacebook = 'Cannot register with facebook';
  final error = 'Đã xảy ra lỗi. Click để xem chi tiết.';
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
  final profile = 'Trang cá nhân';
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
  final justPostAImage = ' vừa đăng một ảnh mới';
  final justPostImages = ' vừa đăng ảnh mới';
  final justPostAPost = ' vừa đăng bài viết mới';
  final justCreateATour = ' vừa thêm một chuyến đi mới';
  final createdATour = ' đã thêm một chuyến đi mới';
  String totalLike(int totalLike) => '$totalLike lượt yêu thích';
  String viewAllComment(int totalComment) => 'Xem tất cả $totalComment lượt bình luận';
  final addComment = 'Thêm bình luận';
  final reviewTitle = ' đã thêm một nhận xét mới cho ';
}

class _Place {
  String tourCount(int tourCount) => '$tourCount chuyến đi';
}
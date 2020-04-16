class Strings {
  static final appTitle = 'Ginkgo';
  static final common = _Common();
  static final button = _Button();
  static final loginScreen = _LoginScreen();
  static final registerScreen = _RegisterScreen();
}

class _Common {
  final name = 'Họ tên';
  final email = 'Email';
  final phoneNumber = 'Số điện thoại';
  final password = 'Mật khẩu';
  final rePassword = 'Nhập lại mật khẩu';
}

class _Button {
  final login = 'Đăng nhập';
  final register = 'Đăng ký';
  final forgotPassword = 'Quên mật khẩu?';
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

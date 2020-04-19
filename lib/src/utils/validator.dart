import 'package:base/base.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';

String validateEmail(String email) {
  if (!email.isExistAndNotEmpty) {
    return Strings.error.emptyRequiredInput;
  } else if (!email.isEmail) {
    return Strings.error.emailIncorrectForm;
  }
  return null;
}

String validatePassword(String password) {
  if (!password.isExistAndNotEmpty) {
    return Strings.error.emptyRequiredInput;
  }
  return null;
}

String validateName(String name) {
  if (!name.isExistAndNotEmpty) {
    return Strings.error.emptyRequiredInput;
  }
  return null;
}

String validatePhoneNumber(String phoneNumber) {
  if (!phoneNumber.isExistAndNotEmpty) {
    return Strings.error.emptyRequiredInput;
  } else if (!phoneNumber.isVNPhoneNumber) {
    return Strings.error.phoneNumberIncorrectForm;
  }
  return null;
}

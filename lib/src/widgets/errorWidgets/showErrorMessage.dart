import 'package:flutter/material.dart';

import '../customs/toast.dart';

void showErrorMessage(BuildContext context, String message) {
  Toast.show(message, context, duration: 3);
}

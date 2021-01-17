import 'package:get/get.dart';

import 'chat_list_controller.dart';

export 'chat_list_controller.dart';

void initControllers() {
  Get.lazyPut(() => ChatListController());
}

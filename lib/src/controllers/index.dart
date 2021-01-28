import 'package:get/get.dart';
import 'package:ginkgo_mobile/src/controllers/system.controller.dart';

import 'chat_list_controller.dart';

export 'chat_list_controller.dart';
export 'system.controller.dart';

void initControllers() {
  Get.lazyPut(() => ChatListController());
  Get.put(SystemController());
}

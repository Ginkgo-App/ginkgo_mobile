import 'package:get/get.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';

class SystemController extends GetxController {
  final repository = Repository();

  final _notificationCount = 0.obs;
  set notificationCount(value) => this._notificationCount.value = value;
  get notificationCount => this._notificationCount.value;

  @override
  onInit() {
    super.onInit();
    // getNotificationCount();
  }

  Future getNotificationCount() async {
    notificationCount = await repository.system.getNotificationCount();
  }
}

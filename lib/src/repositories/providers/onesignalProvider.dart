import 'package:flutter/foundation.dart';
import 'package:ginkgo_mobile/src/controllers/index.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pedantic/pedantic.dart';
import 'package:base/base.dart';

class OneSignalProvider {
  static final OneSignalProvider _repository = OneSignalProvider._();

  OneSignalProvider._();
  factory OneSignalProvider() => _repository;

  bool _isInited = false;

  Future init() async {
    await OneSignal.shared.init('e87a63aa-3beb-4c15-abbd-71e324625722',
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: true
        });
    await OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      debugPrint('New notification: ${notification.payload.additionalData}');
      Get.find<SystemController>().notificationCount++;
    });

    _handleOpenWhenClick();
    _isInited = true;
    debugPrint('OneSignal: Finished setting up.');
  }

  void _handleOpenWhenClick() {
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      final data = result.notification.payload.additionalData;
      debugPrint(data.toString());
      // if (data != null && data is Map) {
      //   final type = NotificationType(rawValue: data['type']);
      //   final String refUserId = data['refUserId'];
      //   final String refConversationId = data['refConversationId'];

      //   if (type == NotificationType.like ||
      //       type == NotificationType.matching) {
      //     Router.goto(
      //       AppConfig.navigatorKey.currentContext,
      //       UserScreen,
      //       params: UserScreenParams(userId: refUserId),
      //     );
      //   } else if (type == NotificationType.newMessage) {
      //     Router.goto(AppConfig.navigatorKey.currentContext, MessagesScreen,
      //         params: MessagesScreenParams(
      //             ConversationKey(conversationId: refConversationId)));
      //   } else {}

      //   debugPrint(
      //       'Clicked on notification type: ${type.rawValue}, reference user id: $refUserId, reference conversation id: $refConversationId');
      // }
    });
  }

  Future<void> subscribe(String userId) async {
    if (!_isInited) {
      await init();
    }
    await OneSignal.shared.setSubscription(true);
    unawaited(OneSignal.shared
        .setExternalUserId(userId)
        .then((_) => debugPrint('Sent tags userId: $userId to OneSignal.')));
  }

  Future<void> unSubscribe() async {
    if (!_isInited) {
      await init();
    }
    await OneSignal.shared.setExternalUserId('logged out');
  }
}

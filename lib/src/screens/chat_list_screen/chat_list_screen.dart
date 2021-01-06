import 'package:base/base.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:get/state_manager.dart';
import 'package:ginkgo_mobile/src/app.dart';
import 'package:ginkgo_mobile/src/models/conversation.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/screens/chat_list_screen/chat_list_controller.dart';
import 'package:ginkgo_mobile/src/screens/message_screen/message_screen.dart';
import 'package:ginkgo_mobile/src/widgets/userWidgets/user_avatar.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeAgo;

part 'widgets/chat_item.dart';

class ChatListScreen extends GetView<ChatListController> {
  ChatListScreen() {
    if (!controller.isLoading.value) {
      controller.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Tin nhắn',
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Obx(() => controller.isLoading.value
                    ? LoadingIndicator(color: context.colorScheme.primary)
                    : controller.conversations == null ||
                            !controller.conversations.isExistAndNotEmpty
                        ? Center(
                            child: Text(
                              'Chưa có tin nhắn',
                              style: context.textTheme.subtitle1.copyWith(
                                  color: context.colorScheme.onSurface),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            itemCount: controller.conversations.data.length +
                                (!controller.conversations.canLoadmore ? 0 : 3),
                            itemExtent: null,
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemBuilder: (context, index) {
                              return ChatItem(
                                conversation:
                                    controller.conversations.data.getAt(index),
                              );
                            },
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

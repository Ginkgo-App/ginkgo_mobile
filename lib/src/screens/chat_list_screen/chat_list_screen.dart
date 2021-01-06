import 'package:base/base.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:get/state_manager.dart';
import 'package:ginkgo_mobile/src/models/conversation.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/screens/chat_list_screen/chat_list_controller.dart';
import 'package:ginkgo_mobile/src/widgets/userWidgets/user_avatar.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeAgo;

part 'widgets/chat_item.dart';

class ChatListScreen extends GetView<ChatListController> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // await Momentum.controller<ChatPageController>(context).refresh();
      },
      child: Container(
        color: context.colorScheme.background,
        child: Obx(() => Column(
              children: <Widget>[
                _buildHeadingBar(context),
                Expanded(
                  child: controller.isLoading.value
                      ? LoadingIndicator()
                      : controller.conversations == null ||
                              !controller.conversations.isExistAndNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Chưa có tin nhắn',
                                  style: context.textTheme.subtitle1.copyWith(
                                      color: context.colorScheme.onSurface),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: controller.conversations.data.length +
                                  (!controller.conversations.canLoadmore
                                      ? 0
                                      : 3),
                              itemExtent: null,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ChatItem(
                                  conversation: controller.conversations.data
                                      .getAt(index),
                                );
                              },
                            ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildHeadingBar(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 65.0,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10),
        color: context.colorScheme.background,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tin nhắn',
              style: context.textTheme.headline4.copyWith(
                color: context.colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

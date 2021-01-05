import 'package:flutter/material.dart' hide Router;
import 'package:ginkgo_mobile/src/models/conversation.dart';
import 'package:ginkgo_mobile/src/widgets/userWidgets/user_avatar.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeAgo;

import '../../../../base/base.dart';

part 'widgets/chat_item.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> with LoadmoreMixin {
  int messageLength;
  String selectId;
  int selectAction;

  void updateBubble(int val) {
    setState(() {
      messageLength = val;
    });
  }

  @override
  void onLoadMore() {
    // Momentum.controller<ChatPageController>(context).loadmore();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // await Momentum.controller<ChatPageController>(context).refresh();
      },
      child: Container(
        color: context.colorScheme.background,
        child: Column(
          children: <Widget>[
            buildHeadingBar(context),
            Expanded(
              child: 'model.isLoading' == null
                  ? LoadingIndicator()
                  : 'model.conversations.isEmpty' == null
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
                          controller: scrollController,
                          padding: EdgeInsets.zero,
                          itemCount: 0 + ('model.isLastPage' == null ? 0 : 3),
                          itemExtent: null,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ChatItem(
                              conversation:
                                  null, //model.conversations.getAt(index),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBadge(int length) {
    return length <= 0
        ? const SizedBox.shrink()
        : Container(
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 20,
            height: 20,
            child: Center(
              child: Text(
                length.toString(),
                style: TextStyle(
                    color: context.colorScheme.onPrimary, fontSize: 11),
              ),
            ),
          );
  }

  Widget buildHeadingBar(BuildContext context) {
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

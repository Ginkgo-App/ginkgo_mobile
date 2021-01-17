import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';
import 'package:ginkgo_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/currentUser/current_user_bloc.dart';
import 'package:ginkgo_mobile/src/models/conversation.dart';
import 'package:ginkgo_mobile/src/models/conversation_key.dart';
import 'package:ginkgo_mobile/src/models/message.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/packages/dash_chat/dash_chat.dart';
import 'package:ginkgo_mobile/src/screens/message_screen/message_screen_controller.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/userWidgets/user_avatar.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class MessagesScreenArgs {
  final ConversationKey conversationKey;
  final Conversation conversation;

  MessagesScreenArgs({this.conversationKey, this.conversation});
}

class MessagesScreen extends StatelessWidget {
  final MessagesScreenArgs args;

  const MessagesScreen({Key key, @required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (args.conversation == null && args.conversationKey == null) {
      Fluttertoast.showToast(msg: 'Incorrect screen arguments.');
      Navigator.pop(context);
    }
    return GetBuilder<MessageScreenController>(
      init: MessageScreenController(args),
      builder: (controller) {
        return Obx(() {
          return PrimaryScaffold(
            isLoading: controller.isLoading.value,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: context.colorScheme.background,
              shadowColor: context.colorScheme.onBackground,
              elevation: 1,
              leading: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.chevron_left,
                    color: context.colorScheme.onBackground,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Skeleton(
                enabled: false,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        child: UserAvatar(
                          size: 30,
                          image: controller.conversation?.image ??
                              MultiSizeImage(''),
                          showOnline: false,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SkeletonItem(
                              child: Text(
                                controller.conversation?.name ?? 'Loading',
                                style: context.textTheme.bodyText1
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            if ('model.conversation?.lastOnline' == null)
                              SkeletonItem(
                                child: Text(
                                  Strings.messageScreen.lastOnlineAt(timeAgo
                                      .format(DateTime.now(), locale: 'vi')),
                                  style: context.textTheme.caption,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: DashChat(
              onLoadEarlier: () {
                controller.loadmore();
              },
              inverted: true,
              dateFormat: DateFormat('dd/MM/yyyy'),
              timeFormat: DateFormat('HH:mm'),
              user: CurrentUserBloc().currentUser.toSimpleUser(),
              messages: <Message>[
                ...controller.isLoading.value ? [] : controller.messages.data,
                ...controller.messages.canLoadmore || controller.isLoading.value
                    ? List.generate(
                        controller.isLoading.value ? 10 : 2, (_) => null)
                    : [],
              ].toList(),
              onSend: (Message message) {
                controller?.sendMessage(message: message.message);
              },
              inputContainerStyle: BoxDecoration(
                border: Border(
                  top: BorderSide(color: context.colorScheme.onSurface),
                ),
              ),
              inputDecoration: InputDecoration(
                hintText: Strings.messageScreen.hint,
              ),
              sendButtonBuilder: (onSend) {
                return IconButton(
                    icon: controller.isSendingMessage.value
                        ? LoadingIndicator(size: 20)
                        : Icon(Icons.send),
                    onPressed:
                        controller.isSendingMessage.value ? null : onSend);
              },
            ),
          );
        });
      },
    );
  }
}

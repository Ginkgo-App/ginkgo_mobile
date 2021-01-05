import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/conversation_key.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/userWidgets/user_avatar.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class MessagesScreenArgs {
  final ConversationKey conversationKey;

  MessagesScreenArgs(this.conversationKey);
}

class MessagesScreen extends StatefulWidget {
  final MessagesScreenArgs args;

  const MessagesScreen({Key key, @required this.args}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
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
                    image: MultiSizeImage(''),
                    isOnline: true,
                    showOnline: true,
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
                          'model.conversation?.name' ?? 'Loading',
                          style: context.textTheme.bodyText1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      if ('model.conversation?.lastOnline' != null)
                        SkeletonItem(
                          child: Text(
                            Strings.messageScreen.lastOnlineAt(
                                timeAgo.format(DateTime.now(), locale: 'vi')),
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
      // body: DashChat(
      //         onLoadEarlier: () {
      //           // model.controller.loadmore();
      //         },
      //         inverted: true,
      //         dateFormat: DateFormat('dd/MM/yyyy'),
      //         timeFormat: DateFormat('HH:mm'),
      //         user: null,
      //         messages: <Message>[
      //           ...model.isLoading ? [] : model.messages,
      //           ...!model.isLastPage || model.isLoading
      //               ? List.generate(model.isLoading ? 10 : 2, (_) => null)
      //               : [],
      //         ].toList(),
      //         onSend: (Message message) {
      //           controller?.sendMessage(message: message.message);
      //         },
      //         inputContainerStyle: BoxDecoration(
      //           border: Border(
      //             top: BorderSide(color: context.colorScheme.onSurface),
      //           ),
      //         ),
      //         inputDecoration: InputDecoration(
      //           hintText: Strings.messageScreen.hint,
      //         ),
      //         sendButtonBuilder: (onSend) {
      //           return IconButton(
      //               icon: model.isSendingMessage
      //                   ? LoadingIndicator(size: 20)
      //                   : Icon(Icons.send),
      //               onPressed: model.isSendingMessage ? null : onSend);
      //         },
      //       ),
    );
  }
}

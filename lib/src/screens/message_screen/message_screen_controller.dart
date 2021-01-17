import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ginkgo_mobile/src/blocs/currentUser/current_user_bloc.dart';
import 'package:ginkgo_mobile/src/models/conversation.dart';
import 'package:ginkgo_mobile/src/models/message.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:ginkgo_mobile/src/screens/message_screen/message_screen.dart';

class MessageScreenController extends GetxController {
  Repository _repository = Repository();
  final MessagesScreenArgs args;
  MessageScreenController(this.args);

  final Rx<Conversation> _conversation = Rx();
  final Rx<Pagination<Message>> _messages = Rx(Pagination<Message>());
  final error = ''.obs;
  final isLoading = false.obs;
  final isSendingMessage = false.obs;

  set conversation(Conversation value) => this._conversation.value = value;
  Conversation get conversation => this._conversation.value;

  set messages(Pagination<Message> value) => this._messages.value = value;
  Pagination<Message> get messages => this._messages.value;

  @override
  void onInit() async {
    super.onInit();
    _repository.chat.subcribeNewMessage().listen(onNewMessage);
    await loadConversation();
    await loadMessage();
  }

  Future loadConversation() async {
    if (args.conversation != null) {
      this.conversation = args.conversation;
    } else {
      this.conversation =
          await _repository.chat.getConversationDetail(args.conversationKey);
    }
  }

  Future loadMessage() async {
    await _loadMessage();
  }

  void sendMessage({String message, List<File> attachments}) async {
    try {
      isSendingMessage.value = true;
      await _repository.chat.sendMessage(conversation.id, message);
      messages.data.insert(
          0,
          Message(
            message: message,
            sender: CurrentUserBloc().currentUser.toSimpleUser(),
            createdAt: DateTime.now(),
          ));
      update();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isSendingMessage.value = false;
    }
  }

  Future loadmore() async {
    if (!messages.canLoadmore) return;
    _trycatch((() async {
      _messages.value.add(await _repository.chat.getMessages(conversation.id,
          page: messages.pagination.currentPage + 1));
      update();
    })());
  }

  void onNewMessage(MessageFromStream message) {
    if (message != null && message.conversation?.id == conversation.id) {
      messages.data.insert(0, message);
      update();
    }
  }

  Future _loadMessage({int page = 1}) async {
    await _trycatch((() async {
      _messages.value =
          await _repository.chat.getMessages(conversation.id, page: page);
    })());
  }

  Future _loading(Future func) async {
    isLoading.value = true;
    await _trycatch(func, onFinally: () {
      isLoading.value = false;
    });
  }

  Future _trycatch(Future func, {Function onError, Function onFinally}) async {
    try {
      await func;
    } catch (e) {
      await Fluttertoast.showToast(msg: e.toString());
      onError?.call();
      rethrow;
    } finally {
      onFinally?.call();
    }
  }
}

import 'package:get/get.dart';
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

  set conversation(Conversation value) => this._conversation.value = value;
  Conversation get conversation => this._conversation.value;

  final Rx<Pagination<Message>> _messages = Rx();
  set messages(Pagination<Message> value) => this._messages.value = value;
  Pagination<Message> get messages => this._messages.value;

  @override
  void onInit() async {
    super.onInit();
    await loadConversation();
  }

  Future loadConversation() async {
    if (args.conversation != null) {
      this.conversation = args.conversation;
    } else {
      this.conversation =
          await _repository.chat.getConversationDetail(args.conversationKey);
    }
  }

  Future _loadMessage() async {
    throw UnimplementedError();
  }
}

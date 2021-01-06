import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ginkgo_mobile/src/models/conversation.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';

class ChatListController extends GetxController {
  final Repository repository = Repository();

  final Rx<Pagination<Conversation>> _conversations = Rx(Pagination());
  set conversations(Pagination<Conversation> value) =>
      this._conversations.value = value;
  Pagination<Conversation> get conversations => this._conversations.value;

  final _isLoading = false.obs;
  RxBool get isLoading => this._isLoading;

  @override
  void onInit() {
    _isLoading.value = true;
    _reload().whenComplete(() => _isLoading.value = false);
    super.onInit();
  }

  Future refresh() => _reload();

  Future _reload() async {
    try {
      final data = await repository.chat.getList(page: 1);
      conversations = data;
      debugPrint('Reload conversations');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      throw e;
    }
  }
}

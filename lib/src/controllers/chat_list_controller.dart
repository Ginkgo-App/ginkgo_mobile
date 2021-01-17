import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ginkgo_mobile/src/models/conversation.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';

import '../models/message.dart';

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
    repository.chat.subcribeNewMessage().listen(onNewMessage);
    super.onInit();
  }

  Future refresh() => _reload();

  void onNewMessage(MessageFromStream message) {
    if (message?.conversation != null) {
      final index = _conversations.value.data
          .indexWhere((element) => element.id == message.conversation?.id);
      if (index >= 0) {
        _conversations.value.data.removeAt(index);
      }
      _conversations.value.data.insert(0, message.conversation);
      update();
    }
  }

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

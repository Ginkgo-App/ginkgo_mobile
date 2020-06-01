import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/widgets/autoHeightGridView.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class FriendListWidget extends StatefulWidget {
  final List<SimpleUser> friends;
  final bool isLoading;
  final bool canLoadmore;
  final Function onLoadingMore;
  final Function onFirstFetch;
  final bool readonly;

  const FriendListWidget({
    Key key,
    this.isLoading = true,
    @required this.friends,
    this.canLoadmore = false,
    this.onLoadingMore,
    this.onFirstFetch,
    this.readonly = true,
  }) : super(key: key);

  @override
  _FriendListWidgetState createState() => _FriendListWidgetState();
}

class _FriendListWidgetState extends State<FriendListWidget>
    with LoadmoreMixin {
  @override
  void initState() {
    super.initState();
    widget.onFirstFetch?.call();
  }

  @override
  onLoadMore() {
    widget.onLoadingMore?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AutoHeightGridView(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: widget.isLoading || widget.friends == null
              ? List.generate(
                  10, (_) => UserFriendWidget(readonly: widget.readonly))
              : [
                  ...widget.friends
                      .map<Widget>((e) =>
                          UserFriendWidget(user: e, readonly: widget.readonly))
                      .toList(),
                  if (widget.canLoadmore)
                    ...List.generate(
                        2, (_) => UserFriendWidget(readonly: widget.readonly))
                ],
        ),
      ),
    );
  }
}

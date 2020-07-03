import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/post_list/post_list_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/commonOutlineButton.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/errorIndicator.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/not_found_widget.dart';
import 'package:ginkgo_mobile/src/widgets/post_widgets/post_widget.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class FeedTab extends StatefulWidget {
  @override
  _FeedTabState createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> with LoadmoreMixin {
  final PostListBloc postListBloc = PostListBloc(5);

  initState() {
    super.initState();
    loadData();
  }

  loadData() {
    postListBloc.add(PostListEventFetch());
  }

  @override
  onLoadMore() {
    postListBloc.add(PostListEventLoadMore());
  }

  @override
  void dispose() {
    postListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: postListBloc,
      builder: (context, state) {
        if (state is PostListStateSuccess &&
            postListBloc.postList.pagination.totalElement == 0) {
          return NotFoundWidget(
            message: 'Không có tin tức mới!',
            showBorderBox: false,
          );
        }

        return ListView(
          // controller: scrollController,
          // physics: NeverScrollableScrollPhysics(),
          // itemExtent: null,
          // shrinkWrap: true,
          // padding: EdgeInsets.zero,
          children: [
            ...<Post>[
              ...postListBloc.postList.data,
              if (state is PostListStateLoading)
                ...List.generate(10, (index) => null)
            ]
                .map<Widget>(
                  (e) => BorderContainer(
                    childPadding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: PostWidget(
                      post: e,
                      showAuthorAvatar: true,
                      onDeleted: (post) {
                        postListBloc.add(PostListEventRemovePost(post));
                      },
                    ),
                  ),
                )
                .toList(),
            if (state is PostListStateFailure)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ErrorIndicator(
                  moreErrorDetail: state.error.toString(),
                  onReload: () {
                    postListBloc.add(PostListEventLoadMore(true));
                  },
                ),
              )
            else if (postListBloc.postList.canLoadmore)
              CommonOutlineButton(
                onPressed: onLoadMore,
                text: 'Xem thêm',
              )
          ],
        );
      },
    );
  }
}

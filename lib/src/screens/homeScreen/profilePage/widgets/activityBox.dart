import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/post_list/post_list_bloc.dart';
import 'package:ginkgo_mobile/src/models/fakeData.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/errorIndicator.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/not_found_widget.dart';
import 'package:ginkgo_mobile/src/widgets/post_widgets/post_widget.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:base/base.dart';

class ActivityBox extends StatefulWidget {
  final int userId;

  const ActivityBox({Key key, @required this.userId}) : super(key: key);

  @override
  _ActivityBoxState createState() => _ActivityBoxState();
}

class _ActivityBoxState extends State<ActivityBox> with LoadDataWidgetMixin {
  PostListBloc postListBloc;

  initState() {
    super.initState();
    postListBloc = PostListBloc(5, userId: widget.userId);
  }

  loadData() {
    postListBloc.add(PostListEventFetch());
  }

  dispose() {
    postListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      icon: Assets.icons.activity,
      title: 'Hoạt động',
      childPadding: EdgeInsets.all(10),
      child: BlocBuilder(
        bloc: postListBloc,
        builder: (context, state) {
          if (state is PostListStateFailure) {
            return ErrorIndicator(
              moreErrorDetail: state.error.toString(),
              onReload: loadData,
            );
          } else if (state is PostListStateSuccess &&
              postListBloc.postList.pagination.totalElement == 0) {
            return NotFoundWidget(
                message: 'Chưa có trạng thái nào được cập nhật!');
          }

          return ListView(
            itemExtent: null,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: postListBloc.postList.data
                .map<Widget>((e) => PostWidget(post: e))
                .toList()
                .addBetweenEvery(SizedBox(height: 20)),
          );
        },
      ),
    );
  }
}

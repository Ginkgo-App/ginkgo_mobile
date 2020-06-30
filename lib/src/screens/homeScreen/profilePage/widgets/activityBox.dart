import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/post_list/post_list_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/errorIndicator.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/not_found_widget.dart';
import 'package:ginkgo_mobile/src/widgets/post_widgets/post_widget.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class ActivityBox extends StatefulWidget {
  final PostListBloc postListBloc;

  const ActivityBox({Key key, @required this.postListBloc}) : super(key: key);

  @override
  _ActivityBoxState createState() => _ActivityBoxState();
}

class _ActivityBoxState extends State<ActivityBox> {
  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      icon: Assets.icons.activity,
      title: 'Hoạt động',
      child: BlocBuilder(
        bloc: widget.postListBloc,
        builder: (context, state) {
          if (state is PostListStateSuccess &&
              widget.postListBloc.postList.pagination.totalElement == 0) {
            return NotFoundWidget(
              message: 'Chưa có trạng thái nào được cập nhật!',
              showBorderBox: false,
            );
          }

          return ListView(
            itemExtent: null,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              ...<Post>[
                ...widget.postListBloc.postList.data,
                if (state is PostListStateLoading)
                  ...List.generate(3, (index) => null)
              ]
                  .map<Widget>((e) => PostWidget(post: e))
                  .toList()
                  .addBetweenEvery(SizedBox(height: 20)),
              if (state is PostListStateFailure)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ErrorIndicator(
                    moreErrorDetail: state.error.toString(),
                    onReload: () {
                      widget.postListBloc.add(PostListEventLoadMore(true));
                    },
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}

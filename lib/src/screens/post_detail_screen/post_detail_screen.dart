part of '../screens.dart';

class PostDetailScreenArgs {
  final Post post;

  PostDetailScreenArgs(this.post);
}

class PostDetailScreen extends StatelessWidget {
  final PostDetailScreenArgs args;

  const PostDetailScreen({Key key, @required this.args})
      : assert(args != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(),
      body: PostWidget(
        isCollapse: false,
        showAuthorAvatar: true,
        post: args.post,
      ),
    );
  }
}

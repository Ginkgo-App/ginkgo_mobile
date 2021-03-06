part of post_widgets;

class PostLikeCommentButton extends StatefulWidget {
  final Post post;
  final Function onCommentPressed;

  const PostLikeCommentButton(
      {Key key, @required this.post, this.onCommentPressed})
      : assert(post != null),
        super(key: key);
  @override
  _PostLikeCommentButtonState createState() => _PostLikeCommentButtonState();
}

class _PostLikeCommentButtonState extends State<PostLikeCommentButton> {
  bool _isLiked;
  int _totalLike;

  initState() {
    super.initState();
    _isLiked = widget.post?.isLiked ?? false;
    _totalLike = widget.post?.totalLike ?? 0;
  }

  Future<bool> _onLikePressed(isLiked) async {
    final currentState = LikePostBloc().state;
    if (currentState is LikePostStateLoading &&
        currentState.postId == widget.post?.id) return isLiked;

    setState(() {
      this._isLiked = !isLiked;
      if (this._isLiked) {
        LikePostBloc().add(LikePostEventLike(widget.post?.id));
        this._totalLike++;
      } else {
        LikePostBloc().add(LikePostEventUnlike(widget.post?.id));
        this._totalLike--;
      }
    });

    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: LikePostBloc(),
      listener: (context, state) {
        if (state is LikePostStateFailure && state.postId == widget.post?.id) {
          setState(() {
            this._isLiked = !this._isLiked;
            if (this._isLiked) {
              this._totalLike++;
            } else {
              this._totalLike--;
            }
          });
          showErrorMessage('Xảy ra lỗi. Hãy thử lại.\n${state.error}');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SpacingRow(
            spacing: 10,
            children: <Widget>[
              LikeButton(
                isLiked: _isLiked,
                size: 20,
                likeBuilder: (isLiked) {
                  return SvgPicture.asset(
                    isLiked
                        ? Assets.icons.heartFull
                        : Assets.icons.heartOutline,
                  );
                },
                onTap: _onLikePressed,
              ),
              CupertinoButton(
                minSize: 0,
                padding: EdgeInsets.zero,
                child: SvgPicture.asset(Assets.icons.comment, height: 18),
                onPressed: widget.onCommentPressed,
              ),
            ],
          ),
          if (_totalLike != null && _totalLike > 0) ...[
            const SizedBox(height: 5),
            Text(
              Strings.post.totalLike(_totalLike),
              style: TextStyle(
                fontSize: 10,
                color: DesignColor.tinyItems,
              ),
            )
          ]
        ],
      ),
    );
  }
}

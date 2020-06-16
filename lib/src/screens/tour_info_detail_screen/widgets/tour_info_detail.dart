part of 'tour_info_detail_widgets.dart';

class TourInfoDetail extends StatelessWidget {
  final TourInfo tourInfo;
  final bool showCreateBy;

  const TourInfoDetail({
    Key key,
    @required this.tourInfo,
    this.showCreateBy = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      enabled: tourInfo == null,
      child: BorderContainer(
        title: tourInfo.name,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 5),
              if (tourInfo?.rating != null) ...[
                Rating(rating: tourInfo.rating),
                const SizedBox(height: 10),
              ],
              if (showCreateBy && tourInfo?.createBy != null)
                _buildRowIcon(
                  context,
                  icon: Assets.icons.planner,
                  text: tourInfo?.createBy?.displayName ?? '',
                ),
              if (tourInfo.startPlace != null) ...[
                const SizedBox(height: 5),
                _buildRowIcon(
                  context,
                  icon: Assets.icons.startPlace,
                  richText: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: 'Điểm bắt đầu tại ',
                      style: context.textTheme.bodyText2
                          .copyWith(color: context.colorScheme.onBackground),
                      children: <TextSpan>[
                        TextSpan(
                            text: tourInfo?.startPlace?.name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
              if (tourInfo.destinatePlace != null) ...[
                const SizedBox(height: 5),
                _buildRowIcon(
                  context,
                  icon: Assets.icons.startPlace,
                  richText: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: 'Điểm kết thúc tại ',
                      style: context.textTheme.bodyText2
                          .copyWith(color: context.colorScheme.onBackground),
                      children: <TextSpan>[
                        TextSpan(
                            text: tourInfo?.destinatePlace?.name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  _buildRowIcon(BuildContext context,
      {String icon, String text, RichText richText}) {
    return Container(
      color: context.colorScheme.background,
      margin: EdgeInsets.only(right: text.isExistAndNotEmpty ? 0 : 40, top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (text.isExistAndNotEmpty) ...[
            SvgPicture.asset(
              icon,
              height: 14,
              color: context.colorScheme.onBackground,
            ),
            const SizedBox(width: 5),
          ],
          Expanded(
            child: richText == null
                ? Text(
                    text ?? '',
                    style: context.textTheme.bodyText2.copyWith(
                      color: context.colorScheme.onBackground,
                    ),
                  )
                : richText,
          )
        ],
      ),
    );
  }
}

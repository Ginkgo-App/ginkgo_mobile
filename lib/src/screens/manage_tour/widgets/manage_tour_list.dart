part of 'manage_tour_widgets.dart';

class ManageTourList extends StatefulWidget {
  final List<SimpleTour> tours;
  final List<TourInfo> tourInfos;
  final Function onLoadmore;
  final bool isLoading;

  const ManageTourList(
      {Key key,
      this.tours,
      this.tourInfos,
      this.onLoadmore,
      this.isLoading = false})
      : assert(tours == null || tourInfos == null),
        super(key: key);

  @override
  _ManageTourListState createState() => _ManageTourListState();
}

class _ManageTourListState extends State<ManageTourList> with LoadmoreMixin {
  @override
  onLoadMore() {
    if (!widget.isLoading) widget.onLoadmore?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: IntrinsicHeight(
        child: SpacingColumn(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...(widget.tours ?? widget.tourInfos ?? [])
                .map((e) => BlackOpacityTour(
                      tour: e is SimpleTour ? e : null,
                      tourInfo: e is TourInfo ? e : null,
                    ))
                .toList(),
            if (widget.isLoading)
              ...List.generate(5, (_) => BlackOpacityTour()),
          ],
        ),
      ),
    );
  }
}

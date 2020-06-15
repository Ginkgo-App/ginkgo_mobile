part of 'tour_info_detail_widgets.dart';

class TourListBox extends StatelessWidget {
  final List<SimpleTour> tourList;

  const TourListBox({Key key, @required this.tourList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      title: 'Các chuyến đi',
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: tourList != null && tourList.length == 0
            ? NotFoundWidget()
            : IntrinsicHeight(
                child: SpacingColumn(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: (tourList ?? List.generate(5, (_) => null))
                      .map((e) => BlackOpacityTour(tour: e))
                      .toList(),
                ),
              ),
      ),
    );
  }
}

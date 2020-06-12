part of '../screens.dart';

class ChooseTourInfoScreen extends StatefulWidget {
  @override
  _ChooseTourInfoScreenState createState() => _ChooseTourInfoScreenState();
}

class _ChooseTourInfoScreenState extends State<ChooseTourInfoScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Quản lý chuyến đi'),
      body: SingleChildScrollView(
        child: BorderContainer(
          title: 'Khuôn mẫu chuyến đi',
          childPadding: EdgeInsets.zero,
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: IntrinsicHeight(
              child: SpacingColumn(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...List.generate(5, (_) => FakeData.simpleTour)
                      .map((e) => TripItem(tour: e))
                      .toList(),
                  const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

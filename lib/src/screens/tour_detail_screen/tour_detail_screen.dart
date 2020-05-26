part of '../screens.dart';

class TourDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Chi tiết chuyến đi',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SliderWidget(images: FakeData.simpleTour.images),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CollapseContainer(
                height: 300,
                child: Column(
                  children: List.generate(
                    3,
                    (_) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: Random().nextDouble() * 500,
                      color: Color.fromRGBO(Random().nextInt(255),
                          Random().nextInt(255), Random().nextInt(255), 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

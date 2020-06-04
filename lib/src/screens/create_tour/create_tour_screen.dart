part of '../screens.dart';

class CreateTourScreen extends StatefulWidget {
  final TourInfo tourInfo;

  const CreateTourScreen({Key key, this.tourInfo}) : super(key: key);

  @override
  _CreateTourScreenState createState() => _CreateTourScreenState();
}

class _CreateTourScreenState extends State<CreateTourScreen> {
  TourInfo tourInfo;

  @override
  Widget build(BuildContext context) {
    tourInfo = FakeData.tourInfo;
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Tạo chuyến đi',
      ),
      body: Column(
        children: <Widget>[CreateTourSlider(tourInfo: tourInfo)],
      ),
    );
  }
}

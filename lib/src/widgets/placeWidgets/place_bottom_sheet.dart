part of '../widgets.dart';

Future<Place> showPlaceBottomSheet(BuildContext context,
    {Place selectedPlace}) async {
  final currentPlace = selectedPlace;

  showSlidingBottomSheet(
    context,
    builder: (context) {
      return SlidingSheetDialog(
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.8, 0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          headerBuilder: (context, _) {
            return Material(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: GradientOutlineInputBorder(
                        focusedGradient:
                            GradientColor.of(context).primaryGradient,
                        borderRadius: BorderRadius.circular(90),
                        gapPadding: 0,
                      ),
                      hintText: 'Tìm kiếm địa điểm',
                      suffixIcon: Icon(Icons.search),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          Assets.icons.address,
                          height: 20,
                        ),
                      )),
                ),
              ),
            );
          },
          builder: (context, _) {
            return Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(10, (_) => FakeData.place)
                    .map<Widget>(
                      (e) => FlatButton(
                        child: SpacingRow(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(e.name?.toString() ?? '',
                                style: context.textTheme.body1),
                            Icon(
                              Icons.check_circle,
                              color: DesignColor.darkestGreen,
                              size: 12,
                            ),
                          ],
                        ),
                        color: context.colorScheme.background,
                        highlightColor: DesignColor.darkestWhite,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                    .toList()
                    .addBetweenEvery(
                      Container(
                        height: 0.5,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: DesignColor.lightestBlack,
                      ),
                    ),
              ),
            );
          });
    },
  );

  return currentPlace;
}

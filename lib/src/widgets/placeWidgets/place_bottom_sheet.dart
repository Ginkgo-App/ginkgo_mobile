part of '../widgets.dart';

const _SEARCH_BLOCK_DURATION = 500;

class PlaceBottomSheet {
  String _keyword = '';
  BuildContext _context;
  Place _selectedPlace;
  PlaceListBloc _placeListBloc = PlaceListBloc(10);

  PlaceBottomSheet.of(BuildContext context, [Place selectedPlace]) {
    _context = context;
    _selectedPlace = selectedPlace;
    _fetchData();
  }

  Future<Place> show() async {
    await showSlidingBottomSheet(
      _context,
      builder: (context) {
        return SlidingSheetDialog(
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.7, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            cornerRadius: 10,
            headerBuilder: (context, _) {
              return _buildHeader();
            },
            builder: (context, _) {
              return _buildList();
            });
      },
    );

    _placeListBloc.close();
    return _selectedPlace;
  }

  _fetchData() {
    _placeListBloc.add(PlaceListEventFetch(_keyword, null));
  }

  _onLoadMore() {
    _fetchData();
  }

  _buildHeader() {
    final debouncer =
        Debouncer(delay: new Duration(milliseconds: _SEARCH_BLOCK_DURATION));

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder(
          bloc: _placeListBloc,
          builder: (context, state) {
            return TextField(
              onChanged: (v) {
                _keyword = v;
                debouncer.debounce(_fetchData);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: GradientOutlineInputBorder(
                  focusedGradient: GradientColor.of(context).primaryGradient,
                  borderRadius: BorderRadius.circular(90),
                  gapPadding: 0,
                ),
                hintText: 'Tìm kiếm địa điểm',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    Assets.icons.address,
                    height: 20,
                  ),
                ),
                suffixIcon: state is! PlaceListStateLoading
                    ? Icon(Icons.search, size: 20)
                    : SizedBox(
                        width: 20,
                        height: 20,
                        child: LoadingIndicator(
                          size: 10,
                          color: context.colorScheme.primary,
                          padding: EdgeInsets.zero,
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildList() {
    return Material(
      child: BlocBuilder(
        bloc: _placeListBloc,
        builder: (context, state) {
          if (state is PlaceListStateFailure) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ErrorIndicator(
                message: Strings.error.errorClick,
                moreErrorDetail: state.error.toString(),
                onReload: _fetchData,
              ),
            );
          }

          final data = state is PlaceListStateSuccess
              ? state.placeList.data
              : PlaceListBloc.allPlace != null
                  ? PlaceListBloc.allPlace
                  : List<Place>.generate(4, (_) => null);

          data.removeWhere((element) =>
              _selectedPlace != null && element?.id == _selectedPlace?.id);

          if (_selectedPlace != null) data.insert(0, _selectedPlace);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...data
                  .map<Widget>(
                    (e) => _buildPlaceItem(e, _selectedPlace?.id == e?.id),
                  )
                  .toList()
                  .addBetweenEvery(
                    Container(
                      height: 0.5,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: DesignColor.lightestBlack,
                    ),
                  ),
              if (state is! PlaceListStateFailure &&
                  _placeListBloc.placeList.canLoadmore) ...[
                Container(
                  height: 0.5,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  color: DesignColor.lightestBlack,
                ),
                FlatButton(
                  child: state is PlaceListStateLoading
                      ? LoadingIndicator(
                          color: context.colorScheme.primary,
                        )
                      : Container(
                          color: Colors.transparent,
                          child: Text(
                            'Tải thêm',
                            style: _context.textTheme.bodyText2
                                .copyWith(color: Colors.blueAccent),
                          ),
                        ),
                  color: _context.colorScheme.background,
                  highlightColor: DesignColor.darkestWhite,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed:
                      state is PlaceListStateLoading ? null : _onLoadMore,
                )
              ]
            ],
          );
        },
      ),
    );
  }

  _buildPlaceItem(Place data, [bool isSelected = false]) {
    return Skeleton(
      enabled: data == null,
      child: FlatButton(
        child: SpacingRow(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.transparent,
              child: Text(
                data?.name?.toString() ?? '',
                style: _context.textTheme.bodyText2,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: DesignColor.darkestGreen,
                size: 18,
              ),
          ],
        ),
        color: _context.colorScheme.background,
        highlightColor: DesignColor.darkestWhite,
        padding: EdgeInsets.symmetric(vertical: 20),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          _selectedPlace = data;
          Navigator.pop(_context);
        },
      ),
    );
  }
}

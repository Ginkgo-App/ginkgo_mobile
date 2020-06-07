part of 'create_tour_tabs.dart';

class CreateTourTab3 extends StatefulWidget {
  CreateTourTab3({
    Key key,
  }) : super(key: key);

  @override
  _CreateTourTab3State createState() => _CreateTourTab3State();
}

class _CreateTourTab3State extends State<CreateTourTab3> {
  final formKey = GlobalKey<FormState>();

  List<TimelineToPost> timelineList = [];
  DateTime selectedDay;

  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        onChange();
        if (timelineList.length > 0) {
          selectedDay = timelineList[0].day;
        }
      });
    });
  }

  onChange() {
    BlocProvider.of<CreateTourBloc>(context).add(
      CreateTourEventChangeData(
        validate(),
        TourToPost(timelines: timelineList),
      ),
    );
  }

  onDayChange(DateTime startDay, DateTime endDay) {
    if (startDay == null || endDay == null) return;

    final dayDifferent = startDay.difference(endDay).inDays.abs();
    final currentLength = timelineList.length;

    if (currentLength != dayDifferent) {
      setState(() {
        if (currentLength > dayDifferent) {
          timelineList = timelineList.sublist(0, dayDifferent);
        } else {
          timelineList.addAll(
            List.generate(
              dayDifferent - currentLength,
              (i) => TimelineToPost(
                day: startDay.add(Duration(days: currentLength + i)),
                descrirption: '',
                timelineDetails: [],
              ),
            ),
          );
        }
      });
    }
  }

  bool validate() {
    for (final timeline in timelineList) {
      if (timeline.timelineDetails == null ||
          timeline.timelineDetails.length == 0) {
        showErrorMessage(
            context, 'Ngày ${timeline.day.toVietNamese()} chưa có lịch trình.');
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<CreateTourBloc>(context),
      listener: (context, state) {
        if (state is CreateTourStateHaveChanged) {
          onDayChange(state.tourToPost.startDay, state.tourToPost.endDay);
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        physics: NeverScrollableScrollPhysics(),
        child: SpacingColumn(
          spacing: 10,
          children: timelineList
                  ?.where((e) => e.day != null)
                  ?.toList()
                  ?.asMap()
                  ?.map((i, e) {
                    if (selectedDay == null) {
                      selectedDay = e.day;
                    }
                    final isOpening = e.day.compareTo(selectedDay) == 0;
                    final collapseController =
                        CollapseController(isCollapsing: !isOpening);
                    collapseController.addListener(() {
                      if (!collapseController.isCollapsing) {
                        setState(() {
                          selectedDay = e.day;
                        });
                      }
                    });

                    return MapEntry(
                      i,
                      _TimelineItem(
                        timelineToPost: e,
                        isOpening: isOpening,
                        timelineIndex: i,
                        onChangeCollapse: (isCollapsing) {
                          if(!isCollapsing) {
                            setState(() {
                              selectedDay = e.day;
                            });
                          }
                        },
                      ),
                    );
                  })
                  ?.values
                  ?.toList() ??
              [],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final int timelineIndex;
  final TimelineToPost timelineToPost;
  final bool isOpening;
  final Function(bool) onChangeCollapse;

  const _TimelineItem({
    Key key,
    @required this.timelineIndex,
    this.timelineToPost,
    this.isOpening = false, this.onChangeCollapse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CollapseContainer(
      title:
          'Ngày ${timelineIndex + 1} (${timelineToPost?.day?.toVietNamese()})',
      collapseHeight: 0,
      isCollapsing: !isOpening,
      onChangeCollapse: onChangeCollapse, 
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 500,
          color: Colors.red,
        ),
      ),
    );
  }
}

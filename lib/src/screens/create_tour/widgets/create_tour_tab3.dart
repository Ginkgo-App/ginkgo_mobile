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

    final dayDifferent = startDay.difference(endDay).inDays.abs() + 1;
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
        // showErrorMessage('Ngày ${timeline.day.toVietNamese()} chưa có lịch trình.');
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

                    return MapEntry(
                      i,
                      _TimelineItem(
                        timelineToPost: e,
                        isOpening: isOpening,
                        timelineIndex: i,
                        onChanged: (t) {
                          setState(() {
                            timelineList[i] = t;
                            onChange();
                          });
                        },
                        onChangeCollapse: (isCollapsing) {
                          if (!isCollapsing) {
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
  final Function(TimelineToPost) onChanged;

  const _TimelineItem({
    Key key,
    @required this.timelineIndex,
    this.timelineToPost,
    this.isOpening = false,
    this.onChangeCollapse,
    this.onChanged,
  }) : super(key: key);

  onAddItem(TimelineDetailToPost t) {
    timelineToPost.timelineDetails.add(t);
    onChanged?.call(timelineToPost);
  }

  onEditItem(int i, TimelineDetailToPost newV) {
    timelineToPost.timelineDetails[i] = newV;
    onChanged?.call(timelineToPost);
  }

  onRemoveItem(int i) {
    timelineToPost?.timelineDetails?.removeAt(i);
    onChanged?.call(timelineToPost);
  }

  Future<TimelineDetailToPost> onShowTimelineDetailBottomSheet(
      BuildContext context,
      [int index]) async {
    TimelineDetailToPost result;

    await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        cornerRadius: 5,
        builder: (context, _) {
          return CreateTimelineDetail(
            timelineDetail: index != null
                ? CreateTimelineDetailData.fromToPost(
                    timelineToPost.timelineDetails[index])
                : null,
            onSubmit: (data) {
              if (index != null) {
                result = data.toToPost();
                onEditItem(index, result);
              } else {
                result = data.toToPost();
                onAddItem(result);
              }
            },
          );
        },
      );
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return CollapseContainer(
      title:
          'Ngày ${timelineIndex + 1} (${timelineToPost?.day?.toVietNamese()})',
      collapseHeight: 0,
      isCollapsing: !isOpening,
      onChangeCollapse: onChangeCollapse,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: SpacingColumn(
          spacing: 10,
          children: [
            ...timelineToPost?.timelineDetails
                ?.asMap()
                ?.map((i, e) => MapEntry(i, buildTextField(context, i)))
                ?.values
                ?.toList(),
            CreateTourAddButton(
              text: 'Thêm hoạt động',
              onPressed: () => onShowTimelineDetailBottomSheet(context),
            )
          ],
        ),
      ),
    );
  }

  buildTextField(BuildContext context, int i) {
    return TextFormField(
      controller: TextEditingController(
          text: timelineToPost.timelineDetails[i].toString()),
      readOnly: true,
      decoration: InputDecoration(
        fillColor: DesignColor.darkerWhite,
        filled: true,
        contentPadding: EdgeInsets.all(10),
        border: GradientOutlineInputBorder(
          focusedGradient: GradientColor.of(context).primaryGradient,
          borderRadius: BorderRadius.circular(5),
        ),
        suffixIcon: SpacingRow(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          spacing: 5,
          isSpacingHeadTale: true,
          children: [
            GestureDetector(
              child: Icon(
                Icons.edit,
                size: 20,
              ),
              onTap: () {
                onShowTimelineDetailBottomSheet(context, i);
              },
            ),
            GestureDetector(
              child: Icon(
                Icons.close,
                size: 22,
              ),
              onTap: () {
                onRemoveItem(i);
              },
            ),
          ],
        ),
      ),
    );
  }
}

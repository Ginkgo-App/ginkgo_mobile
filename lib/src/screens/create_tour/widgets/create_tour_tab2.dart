part of 'create_tour_tabs.dart';

class CreateTourTab2 extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(DateTime startDay, DateTime endDay, int totalDay,
      int totalNight, List<String> services) onChange;

  CreateTourTab2({
    Key key,
    GlobalKey<FormState> formKey,
    this.onChange,
  })  : this.formKey = formKey ??
            GlobalKey<FormState>(debugLabel: 'CreateTourFormKetTab2'),
        super(key: key);

  @override
  _CreateTourTab2State createState() => _CreateTourTab2State();
}

class _CreateTourTab2State extends State<CreateTourTab2> {
  final TextEditingController startDayController = TextEditingController();
  final TextEditingController endDayController = TextEditingController();
  final TextEditingController totalDayNightController = TextEditingController();

  DateTime startDay;
  DateTime endDay;
  TotalDayNight totalDayNight;
  List<TextEditingController> serviceControllers = [];

  onChange({
    DateTime startDay,
    DateTime endDay,
    TotalDayNight totalDayNight,
    List<String> services,
  }) {
    BlocProvider.of<CreateTourBloc>(context).add(
      CreateTourEventChangeData(
        widget.formKey.currentState.validate(),
        TourToPost(
          startDay: startDay ?? this.startDay,
          endDay: endDay ?? this.endDay,
          totalDay: totalDayNight?.totalDay ?? this.totalDayNight?.totalDay,
          totalNight:
              totalDayNight?.totalNight ?? this.totalDayNight?.totalNight,
          services: services ?? serviceControllers.map((e) => e.text).toList(),
        ),
      ),
    );
  }

  onChangeStartDay(DateTime date) {
    setState(() {
      startDay = date.removeTime();
      startDayController.text = date.toVietNamese();

      if (endDay != null) {
        totalDayNight =
            TotalDayNight.fromDayTime(startDay, endDay, totalDayNight?.type);
        totalDayNightController.text = totalDayNight.toString();
      }
    });

    onChange();
  }

  onChangeEndDay(DateTime date) {
    setState(() {
      endDay = date.removeTime();
      endDayController.text = date.toVietNamese();

      if (startDay != null) {
        totalDayNight =
            TotalDayNight.fromDayTime(startDay, endDay, totalDayNight?.type);
        totalDayNightController.text = totalDayNight.toString();
      }
    });

    onChange();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SpacingColumn(
        spacing: 10,
        isSpacingHeadTale: true,
        children: [
          buildDayRow(),
          buildToTalDayNight(),
          buildServices(),
        ],
      ),
    );
  }

  buildDayRow() {
    return SpacingRow(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: CreateTourTextFieldBase(
            isRequired: true,
            label: 'Ngày bắt đầu:',
            child: GestureDetector(
              onTap: () {
                final maxDay =
                    endDay?.subtract(Duration(days: 1))?.removeTime();
                final minDay = maxDay?.subtract(Duration(days: 30)) ??
                    DateTime.now().add(Duration(days: 1)).removeTime();

                showCustomDatePicker(
                  context,
                  selectedDate: startDay ?? minDay,
                  onSubmit: onChangeStartDay,
                  minimumDate: minDay,
                  maximumDate: maxDay ?? DateTime(3000),
                  buttonLabel: 'Chọn ngày',
                );
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: startDayController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: GradientOutlineInputBorder(
                      focusedGradient:
                          GradientColor.of(context).primaryGradient,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'dd/mm/yyyy',
                    suffixIcon: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          Assets.icons.calendar,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if (!value.isExistAndNotEmpty) {
                      return Strings.error.emptyRequiredInput;
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: CreateTourTextFieldBase(
            isRequired: true,
            label: 'Ngày kết thúc:',
            child: GestureDetector(
              onTap: () {
                final minDay = (startDay?.add(Duration(days: 1)) ??
                        DateTime.now().add(Duration(days: 2)))
                    .removeTime();
                final maxDay = minDay.add(Duration(days: 30));

                showCustomDatePicker(
                  context,
                  selectedDate: endDay ?? minDay,
                  onSubmit: onChangeEndDay,
                  minimumDate: minDay,
                  maximumDate: maxDay,
                  buttonLabel: 'Chọn ngày',
                );
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: endDayController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: GradientOutlineInputBorder(
                      focusedGradient:
                          GradientColor.of(context).primaryGradient,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'dd/mm/yyyy',
                    suffixIcon: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          Assets.icons.calendar,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if (!value.isExistAndNotEmpty) {
                      return Strings.error.emptyRequiredInput;
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildToTalDayNight() {
    return CreateTourTextFieldBase(
      isRequired: true,
      label: 'Tổng thời gian dự kiến:',
      child: GestureDetector(
        onTap: () {
          if (startDay == null || endDay == null) return;
          _showMenuBottomSheet(context, startDay, endDay).then((totalDayNight) {
            setState(() {
              this.totalDayNight = totalDayNight;
              totalDayNightController.text = totalDayNight.toString();
            });

            onChange();
          });
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: totalDayNightController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: GradientOutlineInputBorder(
                  focusedGradient: GradientColor.of(context).primaryGradient,
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: 'Tổng thời gian dự kiến',
                suffixIcon: Icon(Icons.keyboard_arrow_down)),
            validator: (value) {
              if (!value.isExistAndNotEmpty) {
                return Strings.error.emptyRequiredInput;
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  buildServices() {
    return CreateTourTextFieldBase(
      isRequired: false,
      label: 'Các dịch vụ trong chuyến đi:',
      child: SpacingColumn(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          ...serviceControllers
              .asMap()
              .map(
                (i, e) {
                  return MapEntry(
                    i,
                    TextFormField(
                      controller: serviceControllers[i],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: GradientOutlineInputBorder(
                          focusedGradient:
                              GradientColor.of(context).primaryGradient,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: 'Dịch vụ',
                        suffixIcon: GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            setState(() {
                              serviceControllers.removeAt(i);
                            });
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              onChange();
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (!value.isExistAndNotEmpty) {
                          return Strings.error.emptyRequiredInput;
                        }
                        return null;
                      },
                      onFieldSubmitted: (v) {
                        setState(() {
                          onChange();
                        });
                      },
                    ),
                  );
                },
              )
              .values
              .toList(),
          if (serviceControllers.length == 0 ||
              serviceControllers.last.text.isExistAndNotEmpty)
            CreateTourAddButton(
              text: 'Thêm dịch vụ',
              onPressed: () {
                setState(() {
                  serviceControllers.add(TextEditingController());
                });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  onChange();
                });
              },
            )
        ],
      ),
    );
  }
}

Future<TotalDayNight> _showMenuBottomSheet(
    BuildContext context, DateTime startDay, DateTime endDay) async {
  TotalDayNight result;

  List<TotalDayNight> resultList = [
    TotalDayNight.fromDayTime(startDay, endDay, 1),
    TotalDayNight.fromDayTime(startDay, endDay, 2),
    TotalDayNight.fromDayTime(startDay, endDay, 3),
    TotalDayNight.fromDayTime(startDay, endDay, 4),
  ].takeWhile((e) => e.toString().isExistAndNotEmpty).toList();

  await showSlidingBottomSheet(
    context,
    builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        dismissOnBackdropTap: false,
        isDismissable: false,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.8, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        duration: const Duration(milliseconds: 200),
        builder: (context, state) {
          return Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: resultList
                  .map<Widget>(
                    (e) => FlatButton(
                      child: Text(e.toString(),
                          style: context.textTheme.bodyText2),
                      color: context.colorScheme.background,
                      highlightColor: DesignColor.darkestWhite,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        result = e;
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
        },
      );
    },
  );

  return result;
}

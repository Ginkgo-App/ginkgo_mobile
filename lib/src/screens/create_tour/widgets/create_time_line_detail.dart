part of 'create_tour_tabs.dart';

class CreateTimelineDetailData {
  final String time;
  final Place place;
  final String detail;

  CreateTimelineDetailData(this.time, this.place, this.detail);

  factory CreateTimelineDetailData.fromModel(TimelineDetail t) {
    if (t == null) return null;
    return CreateTimelineDetailData(t.time, t.place, t.detail);
  }

  factory CreateTimelineDetailData.fromToPost(TimelineDetailToPost t) {
    if (t == null) return null;
    return CreateTimelineDetailData(t.time, t.place, t.detail);
  }

  TimelineDetailToPost toToPost() {
    return TimelineDetailToPost(time: time, place: place, detail: detail);
  }
}

class CreateTimelineDetail extends StatefulWidget {
  final CreateTimelineDetailData timelineDetail;
  final Function(CreateTimelineDetailData) onSubmit;

  CreateTimelineDetail({Key key, this.timelineDetail, this.onSubmit})
      : super(key: key);

  @override
  _CreateTimelineDetailState createState() => _CreateTimelineDetailState();
}

class _CreateTimelineDetailState extends State<CreateTimelineDetail> {
  final formKey = GlobalKey<FormState>();
  TextEditingController timeController;
  TextEditingController detailController;
  TextEditingController placeController;
  Place selectedPlace;

  initState() {
    super.initState();

    selectedPlace = widget.timelineDetail?.place;

    timeController = TextEditingController(text: widget.timelineDetail?.time);
    detailController =
        TextEditingController(text: widget.timelineDetail?.detail);
    placeController = TextEditingController(text: selectedPlace?.name ?? '');
  }

  onSubmit() {
    if (formKey.currentState.validate()) {
      widget.onSubmit?.call(CreateTimelineDetailData(
        timeController.text,
        selectedPlace,
        detailController.text,
      ));

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: SpacingColumn(
            spacing: 10,
            isSpacingHeadTale: true,
            children: [
              Text(
                widget.timelineDetail == null
                    ? 'Thêm thông tin hoạt động'
                    : 'Sửa thông tin hoạt động',
                style: context.textTheme.headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SpacingRow(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: CreateTourTextFieldBase(
                      isRequired: true,
                      label: 'Thời gian:',
                      child: TextFormField(
                        controller: timeController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: GradientOutlineInputBorder(
                            focusedGradient:
                                GradientColor.of(context).primaryGradient,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: 'Vd: 10 sáng',
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
                  Flexible(
                    flex: 3,
                    child: CreateTourTextFieldBase(
                      label: 'Địa điểm:',
                      child: GestureDetector(
                        onTap: () async {
                          final place =
                              await PlaceBottomSheet.of(context, selectedPlace)
                                  .show();

                          if (place != null && place.id != selectedPlace?.id) {
                            setState(() {
                              selectedPlace = place;
                              placeController.text = selectedPlace?.name;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: placeController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: GradientOutlineInputBorder(
                                focusedGradient:
                                    GradientColor.of(context).primaryGradient,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              hintText: 'Địa điểm',
                              suffixIcon: Icon(Icons.keyboard_arrow_down),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CreateTourTextFieldBase(
                isRequired: true,
                label: 'Nội dung hoạt động:',
                child: TextFormField(
                  controller: detailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: GradientOutlineInputBorder(
                      focusedGradient:
                          GradientColor.of(context).primaryGradient,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'Vd: Nhận đoàn và làm thủ tục tại {{place}}',
                  ),
                  validator: (value) {
                    if (!value.isExistAndNotEmpty) {
                      return Strings.error.emptyRequiredInput;
                    }
                    return null;
                  },
                ),
              ),
              PrimaryButton(
                title: Strings.button.complete,
                onPressed: onSubmit,
              )
            ],
          ),
        ),
      ),
    );
  }
}

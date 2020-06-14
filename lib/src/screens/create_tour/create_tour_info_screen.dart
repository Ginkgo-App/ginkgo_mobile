part of '../screens.dart';

class CreateTourInfoScreen extends StatefulWidget {
  @override
  _CreateTourInfoScreenState createState() => _CreateTourInfoScreenState();
}

class _CreateTourInfoScreenState extends State<CreateTourInfoScreen> {
  final formKey = GlobalKey<FormState>();
  final CreateTourInfoBloc bloc = CreateTourInfoBloc();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController startPlaceController = TextEditingController();
  final TextEditingController endPlaceController = TextEditingController();
  final TextEditingController exactStartPlaceController =
      TextEditingController();
  final TextEditingController exactEndPlaceController = TextEditingController();

  Place startPlace;
  Place endPlace;
  Place exactStartPlace;
  Place exactEndPlace;
  List<FileAsset> images = [];

  onSubmit() {
    if (!formKey.currentState.validate()) return;

    bloc.add(CreateTourInfoEventCreate(TourInfoToPost(
      startPlace: startPlace,
      destinatePlace: endPlace,
      images: images.map((e) => e.file).toList(),
      name: nameController.text,
    )));
  }

  onPickImages() async {
    this.images = [...await pickMultiImage(context, images, maxImages: 10)];
    setState(() {});
  }

  onRemoveImage(FileAsset image) {
    setState(() {
      this.images.remove(image);
    });
  }

  dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is CreateTourInfoStateFailure) {
          showErrorMessage(Strings.error.error + '\n' + state.error.toString());
        } else if (state is CreateTourInfoStateSuccess) {
          Navigators.appNavigator.currentState.pushReplacementNamed(
            Routes.tourInfoDetail,
            arguments: TourInfoDetailScreenArgs(tourInfo: state.newTourInfo),
          );
        }
      },
      child: BlocBuilder(
        bloc: bloc,
        builder: (context, state) => PrimaryScaffold(
          isLoading: state is CreateTourInfoStateLoading,
          appBar: BackAppBar(title: 'Tạo khuôn mẫu chuyến đi'),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(10),
            child: PrimaryButton(
              title: 'Hoàn tất',
              width: double.maxFinite,
              onPressed: onSubmit,
            ),
          ),
          body: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 5),
              Text(
                'Tạo nên khung xương cho những chuyến đi của bạn',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: DesignColor.darkRed),
              ),
              const SizedBox(height: 15),
              CreateTourTextFieldBase(
                isRequired: true,
                label: 'Tên mẫu chuyến đi:',
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: GradientOutlineInputBorder(
                        focusedGradient:
                            GradientColor.of(context).primaryGradient,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: context.colorScheme.background),
                  validator: (value) {
                    if (!value.isExistAndNotEmpty) {
                      return Strings.error.emptyRequiredInput;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              CreateTourTextFieldBase(
                isRequired: true,
                label: 'Địa điểm đầu:',
                child: GestureDetector(
                  onTap: () async {
                    final place =
                        await PlaceBottomSheet.of(context, startPlace).show();

                    if (place != null && place.id != startPlace?.id) {
                      setState(() {
                        startPlace = place;
                        startPlaceController.text = place?.name;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: startPlaceController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: GradientOutlineInputBorder(
                          focusedGradient:
                              GradientColor.of(context).primaryGradient,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: Icon(Icons.expand_more),
                        filled: true,
                        fillColor: context.colorScheme.background,
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
              const SizedBox(height: 10),
              CreateTourTextFieldBase(
                label: 'Địa điểm chính xác (không bắt buộc):',
                child: GestureDetector(
                  onTap: () async {
                    final place =
                        await PlaceBottomSheet.of(context, exactStartPlace)
                            .show();

                    if (place != null && place.id != exactStartPlace?.id) {
                      setState(() {
                        exactStartPlace = place;
                        exactStartPlaceController.text = place?.name;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: exactStartPlaceController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: GradientOutlineInputBorder(
                          focusedGradient:
                              GradientColor.of(context).primaryGradient,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: Icon(Icons.expand_more),
                        filled: true,
                        fillColor: context.colorScheme.background,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CreateTourTextFieldBase(
                isRequired: true,
                label: 'Địa điểm Cuối:',
                child: GestureDetector(
                  onTap: () async {
                    final place =
                        await PlaceBottomSheet.of(context, endPlace).show();

                    if (place != null && place.id != endPlace?.id) {
                      setState(() {
                        endPlace = place;
                        endPlaceController.text = place?.name;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: endPlaceController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: GradientOutlineInputBorder(
                          focusedGradient:
                              GradientColor.of(context).primaryGradient,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: Icon(Icons.expand_more),
                        filled: true,
                        fillColor: context.colorScheme.background,
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
              const SizedBox(height: 10),
              CreateTourTextFieldBase(
                label: 'Địa điểm chính xác (không bắt buộc):',
                child: GestureDetector(
                  onTap: () async {
                    final place =
                        await PlaceBottomSheet.of(context, exactEndPlace)
                            .show();

                    if (place != null && place.id != exactEndPlace?.id) {
                      setState(() {
                        exactEndPlace = place;
                        exactEndPlaceController.text = place?.name;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: exactEndPlaceController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: GradientOutlineInputBorder(
                          focusedGradient:
                              GradientColor.of(context).primaryGradient,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: Icon(Icons.expand_more),
                        filled: true,
                        fillColor: context.colorScheme.background,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CreateTourTextFieldBase(
                isRequired: true,
                label: 'Hình ảnh:',
                child: SpacingRow(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    ...images?.map((e) => buildImageItem(e))?.toList(),
                    GestureDetector(
                      onTap: onPickImages,
                      child: SvgPicture.asset(
                        Assets.icons.addImage,
                        color: context.colorScheme.onBackground,
                        width: 65,
                        height: 45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageItem(FileAsset image) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 5, right: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              image.file.path,
              fit: BoxFit.cover,
              width: 65,
              height: 45,
            ),
          ),
        ),
        Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                onRemoveImage(image);
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: context.colorScheme.error,
                ),
                child: Icon(
                  Icons.clear,
                  size: 15,
                  color: context.colorScheme.onError,
                ),
              ),
            )),
      ],
    );
  }
}

part of '../screens.dart';

class CreateTourScreen extends StatefulWidget {
  final TourInfo tourInfo;

  const CreateTourScreen({Key key, this.tourInfo}) : super(key: key);

  @override
  _CreateTourScreenState createState() => _CreateTourScreenState();
}

class _CreateTourScreenState extends State<CreateTourScreen>
    with TickerProviderStateMixin {
  final CreateTourBloc createTourBloc = CreateTourBloc();

  TabController tabController;
  TourInfo tourInfo;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    if (widget.tourInfo == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigators.appNavigator.currentState
            .pushNamed(Routes.chooseTourInfo)
            .then((v) {
          if (v != null) {
            setState(() {
              tourInfo = v;
              createTourBloc.add(CreateTourEventChangeData(
                  true, TourToPost(tourInfoId: tourInfo.id)));
            });
          } else {
            Navigator.pop(context);
          }
        });
      });
    } else {
      tourInfo = widget.tourInfo;
      createTourBloc.add(
          CreateTourEventChangeData(true, TourToPost(tourInfoId: tourInfo.id)));
    }
  }

  dispose() {
    createTourBloc.close();
    super.dispose();
  }

  onChangeStep(int stepIndex) {
    //Next page
    if (stepIndex > currentStep) {
      if (stepIndex - currentStep >= 2) return;
      if (!submitCurrentStep()) return;
    }

    setState(() {
      currentStep = stepIndex;
      tabController.animateTo(stepIndex);
    });
  }

  submitCurrentStep() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return tourInfo == null
        ? const SizedBox.shrink()
        : BlocProvider.value(
            value: createTourBloc,
            child: BlocListener(
              bloc: createTourBloc,
              listener: (context, state) {
                if (state is CreateTourStateSuccess) {
                  // TODO go to tour detail screen
                  Navigator.pop(context, true);
                }
              },
              child: BlocBuilder(
                bloc: createTourBloc,
                builder: (context, state) {
                  return PrimaryScaffold(
                    isLoading: state is CreateTourStateLoading,
                    appBar: BackAppBar(
                      title: 'Tạo chuyến đi',
                    ),
                    bottomNavigationBar: Container(
                      padding: EdgeInsets.all(10),
                      child: CreateTourBottomButton(
                        currentStep: currentStep,
                        onNextStep: () {
                          onChangeStep(currentStep + 1);
                        },
                        onBackStep: () {
                          onChangeStep(currentStep - 1);
                        },
                      ),
                    ),
                    body: NestedScrollView(
                      headerSliverBuilder: (context, _) {
                        return [
                          SliverPersistentHeader(
                            floating: true,
                            pinned: true,
                            delegate: SliverCreateTourAppBarDelegate(
                              tourInfo,
                              bottom: PreferredSize(
                                child: ProgressBar(
                                  currentIndex: currentStep,
                                  onPageChanged: (i) =>
                                      i < currentStep ? onChangeStep(i) : null,
                                ),
                                preferredSize: Size.fromHeight(110),
                              ),
                            ),
                          ),
                        ];
                      },
                      body: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ExtendedTabBarView(
                          controller: tabController,
                          cacheExtent: 3,
                          physics: NeverScrollableScrollPhysics(),
                          linkWithAncestor: true,
                          children: <Widget>[
                            buildStep1(),
                            buildStep2(),
                            buildStep3(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }

  buildStep1() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          BorderContainer(
            childPadding: EdgeInsets.zero,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CreateTourTab1(
                initTourName: tourInfo.name,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildStep2() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          BorderContainer(
            childPadding: EdgeInsets.zero,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CreateTourTab2(),
            ),
          ),
        ],
      ),
    );
  }

  buildStep3() {
    return CreateTourTab3();
  }
}

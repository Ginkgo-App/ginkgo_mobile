part of '../../base.dart';

class LoadDataProvider extends InheritedWidget {
  final LoadDataController controller;

  LoadDataProvider({@required this.controller, @required Widget child})
      : super(child: child);

  static LoadDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: LoadDataProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class LoadDataController extends ChangeNotifier {
  List<Future Function()> _screenWaiters = [];
  List<Future Function()> _widgetWaiters = [];
  bool _isRefreshing = false;
  bool _isReloading = false;
  bool _isLoading = false;

  bool get isRefreshing => _isRefreshing;
  bool get isReloading => _isReloading;
  bool get isLoading => _isLoading;

  Future loadData() async {
    _isLoading = true;
    notifyListeners();

    await _loadData();

    _isLoading = false;
    notifyListeners();
  }

  Future loadDataForWidget() async {
    _isLoading = true;
    notifyListeners();

    await Future.wait([
      ..._widgetWaiters.map((e) => e.call()),
    ]);

    _isLoading = false;
    notifyListeners();
  }

  Future refresh() async {
    _isRefreshing = true;
    notifyListeners();

    await _loadData();

    _isRefreshing = false;
    notifyListeners();
  }

  Future reload() async {
    _isReloading = true;
    notifyListeners();

    await _loadData();

    _isReloading = false;
    notifyListeners();
  }

  Future _loadData() async {
    await Future.wait([
      ..._screenWaiters.map((e) => e.call()),
      ..._widgetWaiters.map((e) => e.call()),
    ]);
  }
}

mixin LoadDataScreenMixin<T extends StatefulWidget> on State<T> {
  Completer<void> _waitForLoadData = Completer<void>();
  LoadDataController loadDataController;

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    loadDataController = LoadDataController();
    loadDataController._screenWaiters.add(_loadData);
  }

  @protected
  loadData();

  Future _loadData() async {
    loadData?.call();

    _waitForLoadData = Completer<void>();
    await _waitForLoadData.future;
  }

  @protected
  completeLoadData() {
    if (!_waitForLoadData.isCompleted) {
      _waitForLoadData.complete();
    }
  }
}

mixin LoadDataWidgetMixin<T extends StatefulWidget> on State<T> {
  Completer<void> _waitForLoadData = Completer<void>();

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = LoadDataProvider.of(context);

      if (provider == null) {
        throw ('Context have no LoadDataProvider. Please provide it before use LoadDataMixin.');
      } else {
        provider.controller._widgetWaiters.add(_loadData);
      }
    });
  }

  @protected
  loadData();

  Future _loadData() async {
    loadData?.call();

    _waitForLoadData = Completer<void>();
    await _waitForLoadData.future;
  }

  @protected
  completeLoadData() {
    if (!_waitForLoadData.isCompleted) {
      _waitForLoadData.complete();
    }
  }
}

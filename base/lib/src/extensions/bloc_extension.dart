part of base;

extension BlocExtension<Event, State> on Bloc<Event, State> {
  Future wait<T extends State>() async {
    assert(T != null);
    final Completer<void> _waitState = Completer<void>();
    
    final listener = this.listen((state) {
      if (state is T) {
        _waitState.complete();
      }
    });

    await _waitState.future;
    listener.cancel();
  }
}

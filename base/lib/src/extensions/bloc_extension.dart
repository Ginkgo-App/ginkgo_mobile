part of base;

extension BlocExtension<Event, State> on Bloc<Event, State> {
  Future waitOne(List<Type> states) async {
    assert(states != null);
    final Completer<void> _waitState = Completer<void>();

    final listener = this.listen((state) {
      if (states.contains(state.runtimeType)) {
        _waitState.complete();
      }
    });

    try {
      await _waitState.future;
    } finally {
      listener.cancel();
    }
  }
}

part of base;

extension BlocExtension<Event, State> on Bloc<Event, State> {
  Future waitOne(List<Type> states, {List<Type> throwStates = const []}) async {
    assert(states != null);
    final Completer<void> _waitState = Completer<void>();

    final listener = this.listen((state) {
      if (states.contains(state.runtimeType)) {
        _waitState.complete();
      } else if (throwStates.contains(state)) {
        _waitState.completeError(state);
      }
    });

    try {
      await _waitState.future;
    } finally {
      listener.cancel();
    }
  }
}

part of base;

abstract class ErrorState {
  final dynamic error;

  ErrorState(this.error);

  @override
  String toString() => '$runtimeType ${error.toString()}';
}

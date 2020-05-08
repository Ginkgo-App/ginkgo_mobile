part of base;

class ServerError {
  final int errorCode;
  final String message;

  ServerError({@required this.errorCode, @required this.message});

  @override
  String toString() => message;
}
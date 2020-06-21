part of 'models.dart';

class KeyValue extends Equatable {
  final String key;
  final String value;

  const KeyValue({@required this.key, @required this.value});

  @override
  List<Object> get props => [key];
}

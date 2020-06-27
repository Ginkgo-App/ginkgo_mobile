part of 'post_list_bloc.dart';

@immutable
abstract class PostListEvent {
  @override
  String toString() => runtimeType.toString();
}

class PostListEventFetch extends PostListEvent {
  final String keyword;

  PostListEventFetch({this.keyword});

  @override
  String toString() => '$runtimeType Keyword: $keyword';
}

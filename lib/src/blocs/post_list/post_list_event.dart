part of 'post_list_bloc.dart';

@immutable
abstract class PostListEvent {
  @override
  String toString() => runtimeType.toString();
}

class PostListEventFetch extends PostListEvent {}

class PostListEventLoadMore extends PostListEvent {
  final bool force;

  PostListEventLoadMore([this.force = false]);
}

part of 'post_detail_bloc.dart';

@immutable
abstract class PostDetailEvent {
  @override
  String toString() => runtimeType.toString();
}

class PostDetailEventChangeLike extends PostDetailEvent {
  final bool isIncrease;

  PostDetailEventChangeLike({this.isIncrease = true});

  @override
  String toString() => '$runtimeType $isIncrease';
}

class PostDetailEventChangeComment extends PostDetailEvent {
  final bool isIncrease;

  PostDetailEventChangeComment({this.isIncrease = true});

  @override
  String toString() => '$runtimeType $isIncrease';
}

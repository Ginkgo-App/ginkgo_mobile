part of 'post_detail_bloc.dart';

@immutable
abstract class PostDetailState {
  @override
  String toString() => runtimeType.toString();
}

class PostDetailInitial extends PostDetailState {}

class PostDetailStateHaveChange extends PostDetailState {}

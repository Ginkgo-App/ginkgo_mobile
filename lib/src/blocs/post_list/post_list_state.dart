part of 'post_list_bloc.dart';

@immutable
abstract class PostListState {
  @override
  String toString() => runtimeType.toString();
}

class PostListInitial extends PostListState {}

class PostListStateLoading extends PostListState {}

class PostListStateSuccess extends PostListState {
  final Pagination<Post> postList;

  PostListStateSuccess(this.postList);

  @override
  String toString() =>
      '$runtimeType TotalCurrentElement ${postList.data.length} TotalPage: ${postList.pagination.totalPage}';
}

class PostListStateFailure extends PostListState {
  final dynamic error;

  PostListStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}

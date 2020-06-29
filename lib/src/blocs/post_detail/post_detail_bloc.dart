import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:meta/meta.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  Post _post;
  Post get post => _post;

  PostDetailBloc(this._post);

  @override
  PostDetailState get initialState => PostDetailInitial();

  @override
  Stream<PostDetailState> mapEventToState(
    PostDetailEvent event,
  ) async* {}
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/blocs/currentUser/current_user_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/user_friends/user_friends_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'add_friend_event.dart';
part 'add_friend_state.dart';

class AddFriendBloc extends Bloc<AddFriendEvent, AddFriendState> {
  final Repository _repository = Repository();

  @override
  AddFriendState get initialState => AddFriendInitial();

  @override
  Stream<AddFriendState> mapEventToState(
    AddFriendEvent event,
  ) async* {
    try {
      if (event is AddFriendEventAcceptFriend) {
        yield AddFriendStateLoading();
        await _repository.user.acceptFriend(event.user.id);
        yield AddFriendStateSuccess(event.user);
        CurrentUserBloc().acceptedFriendsBloc.add(UserFriendsEventAddToList(
            event.user..friendType = FriendType.accepted));
        CurrentUserBloc()
            .requestedFriendsBloc
            .add(UserFriendsEventRemoveFromList(event.user.id));
      } else if (event is AddFriendEventAddFriend) {
        yield AddFriendStateLoading();
        await _repository.user.addFriend(event.user.id);
        yield AddFriendStateSuccess(event.user);
        CurrentUserBloc()
            .waitingFriendsBloc
            .add(UserFriendsEventAddToList(event.user));
      } else if (event is AddFriendEventRemoveFriend) {
        yield AddFriendStateLoading();
        await _repository.user.removeFriend(event.user.id);
        yield AddFriendStateSuccess(event.user);
        CurrentUserBloc()
            .acceptedFriendsBloc
            .add(UserFriendsEventRemoveFromList(event.user.id));
        CurrentUserBloc()
            .requestedFriendsBloc
            .add(UserFriendsEventRemoveFromList(event.user.id));
        CurrentUserBloc()
            .waitingFriendsBloc
            .add(UserFriendsEventRemoveFromList(event.user.id));
      }
    } catch (e) {
      yield AddFriendStateFailure(e);
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/blocs/currentUser/current_user_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/current_user_friends/current_user_friends_bloc.dart';
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
        yield AddFriendStateSuccess();
        CurrentUserBloc().acceptedFriendsBloc.add(
            CurrentUserFriendsEventAddToList(
                event.user..friendType = FriendType.accepted));
        CurrentUserBloc()
            .requestedFriendsBloc
            .add(CurrentUserFriendsEventRemoveFromList(event.user.id));
      } else if (event is AddFriendEventAddFriend) {
        yield AddFriendStateLoading();
        await _repository.user.addFriend(event.user.id);
        yield AddFriendStateSuccess();
        CurrentUserBloc()
            .waitingFriendsBloc
            .add(CurrentUserFriendsEventAddToList(event.user));
      } else if (event is AddFriendEventRemoveFriend) {
        yield AddFriendStateLoading();
        await _repository.user.removeFriend(event.userId);
        yield AddFriendStateSuccess();
        CurrentUserBloc()
            .acceptedFriendsBloc
            .add(CurrentUserFriendsEventRemoveFromList(event.userId));
        CurrentUserBloc()
            .requestedFriendsBloc
            .add(CurrentUserFriendsEventRemoveFromList(event.userId));
        CurrentUserBloc()
            .waitingFriendsBloc
            .add(CurrentUserFriendsEventRemoveFromList(event.userId));
      }
    } catch (e) {
      yield AddFriendStateFailure(e);
    }
  }
}

part of '../screens.dart';

class ProfileScreen extends StatelessWidget {
  final CurrentUserBloc _bloc = CurrentUserBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        User user = User(fullName: 'Loading', avatar: '');
        if (state is CurrentUserSuccess) {
          user = state.currentUser;
        }

        return PrimaryScaffold(
          isLoading: state is CurrentUserLoading,
          appBar: BackAppBar(title: user.fullName),
          body: state is CurrentUserFailure
                ? ErrorIndicator(
                    moreErrorDetail: state.error,
                    onReload: () {
                      _bloc.add(CurrentUserEventFetch());
                    },
                  )
                : SingleChildScrollView(
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AvatarWidget(user: user),
                      const SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: <Widget>[
                            OwnerNav(),
                            const SizedBox(height: 10),
                            AboutBox(user: user),
                            const SizedBox(height: 10),
                            FriendList(),
                            const SizedBox(height: 10),
                            InfoBox(user: user),
                            const SizedBox(height: 10),
                            TourListWidget(),
                            const SizedBox(height: 10),
                            ActivityBox(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}

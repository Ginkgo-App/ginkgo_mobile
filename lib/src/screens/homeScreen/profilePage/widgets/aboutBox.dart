import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/update_profile_bloc/update_profile_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/changeButton.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/showErrorMessage.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class AboutBox extends StatefulWidget {
  final User user;
  final bool editMode;

  const AboutBox({Key key, this.user, this.editMode = false}) : super(key: key);

  @override
  _AboutBoxState createState() => _AboutBoxState();
}

class _AboutBoxState extends State<AboutBox> {
  final TextEditingController controller = TextEditingController();
  final UpdateProfileBloc updateProfileBloc = UpdateProfileBloc();
  bool isShowFull = false;
  bool isEditing = false;

  onSubmit() {
    final UserToPut userToPut = UserToPut(bio: controller.text);
    updateProfileBloc.add(UpdateProfileEventUpdate(userToPut));
  }

  @override
  void initState() {
    super.initState();
    controller.text = widget.user?.bio ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    updateProfileBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: updateProfileBloc,
      listener: (context, state) {
        if (state is UpdateProfileStateFailure) {
          showErrorMessage(
              context, Strings.error.updateBio + '\n' + state.error);
        }
      },
      child: widget.editMode ||
              widget?.user?.bio != null && widget.user.bio.isNotEmpty
          ? BorderContainer(
              title: 'Tự giới thiệu',
              icon: Assets.icons.introduction,
              child: isEditing ? buildTextField() : HiddenText(widget.user.bio),
              actions: <Widget>[
                if (widget.editMode)
                  BlocBuilder(
                      bloc: updateProfileBloc,
                      builder: (context, state) {
                        return ChangeButton(
                          isEditing: isEditing,
                          isLoading: state is UpdateProfileStateLoading,
                          onTap: () {
                            if (isEditing) {
                              onSubmit();
                            }

                            setState(() {
                              isEditing = !isEditing;
                            });
                          },
                        );
                      })
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  Widget buildTextField() {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
          hintText: 'Tự giới thiệu',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(2)),
    );
  }
}

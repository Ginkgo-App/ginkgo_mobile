import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/update_profile/update_profile_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/errorIndicator.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

showSloganBottomSheet(BuildContext context, String slogan) {
  final TextEditingController controller = TextEditingController();
  final UpdateProfileBloc updateProfileBloc = UpdateProfileBloc();
  controller.text = slogan;

  // Show bottom sheet
  showSlidingBottomSheet(context, builder: (context) {
    return SlidingSheetDialog(
        elevation: 8,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.8, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        cornerRadius: 5,
        duration: const Duration(milliseconds: 200),
        builder: (context, state) {
          return BlocListener(
            bloc: updateProfileBloc,
            listener: (context, state) {
              if (state is UpdateProfileStateSuccess) {
                Navigator.pop(context);
              }
            },
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Chỉnh sửa câu giới thiệu',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          child: Icon(Icons.clear),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: controller,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: null,
                      style: context.textTheme.caption.copyWith(height: 1.16),
                      autofocus: true,
                      decoration: InputDecoration(
                        fillColor: DesignColor.lighterPink,
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Câu giới thiệu',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: DesignColor.pink)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: DesignColor.pink)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: DesignColor.pink),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder(
                    bloc: updateProfileBloc,
                    builder: (context, state) {
                      return Column(
                        children: <Widget>[
                          if (state is UpdateProfileStateFailure) ...[
                            ErrorIndicator(
                              message: Strings.error.updateSolgan,
                              moreErrorDetail: state.error,
                            ),
                            const SizedBox(height: 10)
                          ],
                          PrimaryButton(
                            title: Strings.button.saveChanges,
                            isLoading: state is UpdateProfileStateLoading,
                            onPressed: () {
                              updateProfileBloc.add(
                                UpdateProfileEventUpdate(
                                  UserToPut(
                                    slogan:
                                        controller.text.replaceAll('\n', ''),
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }).whenComplete(() {
    updateProfileBloc.close();
  });
}

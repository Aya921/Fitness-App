import 'package:fitness/core/enum/levels.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/helper/string_to_activity_level.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/custom_elevated_button.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/loading_circle.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/features/auth/api/models/register/text_model.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/animate_text.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/select_widget_item.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_intent.dart';
import 'package:flutter/material.dart';

class EditActivityLevelBody extends StatelessWidget {
  final EditProfileCubit cubit;
  final UserEntity? user;
  final EditProfileState state;
  const EditActivityLevelBody({
    super.key,
    required this.cubit,
    required this.user,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: context.setWidth(22)),
              CustomPopIcon(onTap: Navigator.of(context).pop),
              SizedBox(width: context.setWidth(88)),
              const Logo(),
            ],
          ),
          SizedBox(height: context.setHight(88)),
          Padding(
            padding: EdgeInsets.only(left: context.setWidth(24)),
            child: AnimateText(
              textModel: TextModel(title: context.loc.yourRegularPhysical),
            ),
          ),
          BlurContainer(
            blurChild: Column(
              children: [
                ...ActivityLevel.values.map((level) {
                  final selectedLevel =
                      state.updatedLevel ??
                      (user?.activityLevel != null
                          ? activityLevelFromString(user?.activityLevel)
                          : ActivityLevel.level1);

                  return SelectWidgetItem(
                    isSelected: level == selectedLevel,
                    title: level.getLocalizedName(context),
                    onTap: () {
                      cubit.doIntent(intent: LevelChangedIntent(level));
                    },
                  );
                }),
                SizedBox(height: context.setHight(24)),
                CustomElevatedButton(
                  isText: !(state.editProfileStatus?.isLoading ?? false),
                  onPressed:
                      (state.updatedLevel?.name ?? user?.activityLevel) ==
                          user?.activityLevel
                      ? null
                      : () {
                          cubit.doIntent(
                            intent: EditBtnSubmittedIntent(
                              request: EditProfileRequest(
                                firstName: user?.personalInfo?.firstName,
                                lastName: user?.personalInfo?.lastName,
                                email: user?.personalInfo?.email,
                                height: user?.bodyInfo?.height,
                                weight: user?.bodyInfo?.weight,
                                activityLevel: state.updatedLevel?.name,
                                goal: user?.goal,
                              ),
                            ),
                          );
                        },
                  buttonTitle: context.loc.done,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LoadingCircle(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

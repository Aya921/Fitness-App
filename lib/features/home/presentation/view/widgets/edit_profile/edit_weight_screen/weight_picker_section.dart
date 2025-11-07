import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/custom_elevated_button.dart';
import 'package:fitness/core/widget/loading_circle.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_intent.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class WeightPickerSection extends StatelessWidget {
  final EditProfileCubit cubit;
  final UserEntity? user;
  final EditProfileState state;

  const WeightPickerSection({
    super.key,
    required this.cubit,
    required this.user,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final currentWeight = user?.bodyInfo?.weight ?? 60;
    final selectedWeight = state.selectedWeight ?? currentWeight;

    return BlurContainer(
      blurChild: Column(
        children: [
          Text(
            context.loc.kg,
            style: getMediumStyle(
              fontSize: context.setSp(FontSize.s12),
              color: AppColors.orange[AppColors.baseColor]!,
            ),
          ),
          SizedBox(height: context.setHight(20)),
          NumberPicker(
            minValue: 30,
            maxValue: 200,
            value: selectedWeight,
            axis: Axis.horizontal,
            textStyle: getMediumStyle(
              color: AppColors.white,
              fontSize: context.setSp(20),
            ),
            selectedTextStyle: getMediumStyle(
              color: AppColors.orange[AppColors.baseColor]!,
              fontSize: context.setSp(30),
            ),
            onChanged: (value) {
              cubit.doIntent(intent: WeightChangedIntent(value));
            },
          ),
          SizedBox(height: context.setHight(20)),
          Icon(
            Icons.arrow_drop_up,
            size: context.setMinSize(40),
            color: AppColors.orange[AppColors.baseColor],
          ),
          SizedBox(
            width: double.infinity,

            child: CustomElevatedButton(
              isText: !state.editProfileStatus!.isLoading,
              onPressed: selectedWeight == currentWeight
                  ? null
                  : () {
                      cubit.doIntent(
                        intent: EditBtnSubmittedIntent(
                          request: EditProfileRequest(
                            firstName: cubit.firstNameController.text,
                            lastName: cubit.lastNameController.text,
                            email: cubit.emailController.text,
                            height: user?.bodyInfo?.height,
                            weight: selectedWeight,
                            activityLevel: user?.activityLevel,
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
          ),
        ],
      ),
    );
  }
}

import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/helper/string_to_activity_level.dart';
import 'package:flutter/material.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/custom_snack_bar.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_edit_button.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_photo_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_text_fields.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_tab_to_edit_field.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    var user = UserManager().currentUser;
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listenWhen: (previous, current) =>
          previous.editProfileStatus != current.editProfileStatus,
      listener: (context, state) {
        if (state.editProfileStatus!.isSuccess) {
          user = state.editProfileStatus?.data?.user;
          showCustomSnackBar(context, context.loc.profileEditedSuccessfully);
        } else if (state.editProfileStatus!.isFailure) {
          showCustomSnackBar(context, state.editProfileStatus!.error!.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();
        return Form(
          key: cubit.formKey,
          child: SingleChildScrollView(
            child: Column(
              key: const Key(WidgetKey.editProfileBodyColumn),
              children: [
                Row(
                  children: [
                    SizedBox(width: context.setWidth(22)),
                    CustomPopIcon(onTap: Navigator.of(context).pop),
                    SizedBox(width: context.setWidth(88)),
                    Text(
                      "Edit profile",
                      style: getSemiBoldStyle(
                        color: AppColors.white,
                        fontSize: context.setSp(FontSize.s24),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.setHight(40)),
                ProfilePhotoSection(cubit: cubit, user: user!),
                SizedBox(height: context.setHight(8)),
                Text(
                  "${user?.personalInfo?.firstName} ${user?.personalInfo?.lastName}",
                  style: getSemiBoldStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(FontSize.s20),
                  ),
                ),
                SizedBox(height: context.setHight(40)),
                ProfileTextFields(cubit: cubit),
                SizedBox(height: context.setHight(40)),
                ProfileTabToEditField(
                  title: context.loc.yourWeight,
                  value: "${user?.bodyInfo?.weight.toString()} KG",
                  routeToNavigate: AppRoutes.editWeight,
                ),
                ProfileTabToEditField(
                  title: context.loc.yourGoal,
                  value:
                      "${state.updatedGoal ?? state.editProfileStatus?.data?.user?.goal ?? user?.goal}",
                  routeToNavigate: AppRoutes.editGoal,
                ),
                ProfileTabToEditField(
                  title: context.loc.yourLevel,
                  value:
                      state.updatedLevel?.displayName ??
                      activityLevelFromString(
                        user?.activityLevel,
                      )?.getLocalizedName(context) ??
                      '',
                  routeToNavigate: AppRoutes.editLevel,
                ),
                SizedBox(height: context.setHight(24)),
                ProfileEditButton(user: user),
                SizedBox(height: context.setHight(24)),
              ],
            ),
          ),
        );
      },
    );
  }
}

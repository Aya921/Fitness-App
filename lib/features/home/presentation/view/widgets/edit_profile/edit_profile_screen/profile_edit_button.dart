import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/custom_elevated_button.dart';
import 'package:fitness/core/widget/loading_circle.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditButton extends StatelessWidget {
  final UserEntity? user;
  const ProfileEditButton({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.setWidth(30)),
      child: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          final cubit = context.read<EditProfileCubit>();
          return CustomElevatedButton(
            buttonTitle: context.loc.edit,
            isText: !state.editProfileStatus!.isLoading,
            onPressed: state.hasChanges
                ? () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.doIntent(
                        intent: EditBtnSubmittedIntent(
                          request: EditProfileRequest(
                            firstName: cubit.firstNameController.text,
                            lastName: cubit.lastNameController.text,
                            email: cubit.emailController.text,
                            height: user?.bodyInfo?.height,
                            weight: user?.bodyInfo?.weight,
                            activityLevel: user?.activityLevel,
                            goal: user?.goal,
                          ),
                        ),
                      );
                    }
                  }
                : null,
            child: const LoadingCircle(),
          );
        },
      ),
    );
  }
}

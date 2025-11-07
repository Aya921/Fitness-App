import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_activity_level_screen/edit_activity_level_body.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditActivityLevelScreen extends StatelessWidget {
  const EditActivityLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    final user = UserManager().currentUser;

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.editProfileStatus?.isSuccess == true) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AppBackground(
          child: SafeArea(
            child: Scaffold(
              body: EditActivityLevelBody(cubit: cubit, user: user, state: state),

            ),
          ),
        );
      },
    );
  }
}
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/edit_profile_body.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserEntity? user = UserManager().currentUser;

    return Scaffold(
      body: HomeBackground(
        image:  AssetsManager.homeBackground,
        alpha: 0.12,
        child: SafeArea(
          child: BlocProvider(
            create: (context) =>
                getIt<EditProfileCubit>()
                  ..doIntent(intent: InitializeControllers(user)),
            child:const EditProfileBody()
          ),
        ),
      ),
    );
  }
}

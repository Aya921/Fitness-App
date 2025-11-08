import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePhotoSection extends StatelessWidget {
  final EditProfileCubit cubit;
  final UserEntity user;

  const ProfilePhotoSection({
    required this.cubit,
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        ImageProvider backgroundImage;
        if (state.selectedPhoto != null) {
          backgroundImage = FileImage(state.selectedPhoto!);
        } else if (UserManager().currentUser?.personalInfo?.photo?.isNotEmpty ??
            false) {
          backgroundImage = NetworkImage(
            UserManager().currentUser!.personalInfo!.photo!,
          );
        } else {
          backgroundImage = const AssetImage(AssetsManager.defaultUser);
        }

        return Stack(
          key: const Key(WidgetKey.photoSectionStack),
          clipBehavior: Clip.none,
          children: [
            Container(
              key: const Key(WidgetKey.shadowBehindPhoto),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.orange.withAlpha(55),
                    blurRadius: context.setWidth(12),
                    spreadRadius: context.setWidth(2),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: context.setWidth(51),
                backgroundImage: backgroundImage,
              ),
            ),
            Positioned.fill(
              child: Container(
                key: const Key(WidgetKey.transparentLayer),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gray[90]?.withAlpha(120),
                ),
              ),
            ),
            Positioned(
              top: context.setHight(-4),
              right: context.setWidth(-4),
              child: GestureDetector(
                onTap: () => cubit.doIntent(intent: PickPhotoIntent()),

                child: Container(
                  key: const Key(WidgetKey.editIconContainer),
                  width: context.setWidth(25),
                  height: context.setHight(25),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gray[90],
                    border: Border.all(
                      color: AppColors.orange,
                      width: context.setWidth(1.5),
                    ),
                  ),
                  child: SvgPicture.asset(
                    key: const Key(WidgetKey.editIcon),
                    AssetsManager.editSvg,
                    fit: BoxFit.fitHeight,
                    height: context.setHight(25),
                    width: context.setWidth(25),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

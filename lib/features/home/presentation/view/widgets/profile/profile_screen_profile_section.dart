import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreenProfileSection extends StatelessWidget {
  const ProfileScreenProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final userData =state.userData.data?.user?.personalInfo;
        final isLoading =state.userData.isLoading;
        return Skeletonizer(
             enabled:isLoading,
           effect: ShimmerEffect(
                    baseColor: AppColors.gray[AppColors.colorCode70]!,
                    highlightColor: AppColors.gray[AppColors.colorCode40]!,
                  ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Skeleton.keep(
                child: Text(
                  context.loc.profileText,
                  style: getSemiBoldStyle(
                    color: AppColors.white,
                    fontSize: FontSize.s24,
                  ),
                ),
              ),
              SizedBox(height: context.setHight(40)),
              isLoading
    ? Bone.circle(size: context.setMinSize(100))
    :Container(
                width: context.setMinSize(100),
                height: context.setMinSize(100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.orange.withValues(alpha: .25),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: userData?.photo ?? "",
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => const Icon(Icons.info),
                  ),
                ),
              ),
              SizedBox(height: context.setHight(8)),
              FittedBox(
                fit:BoxFit.scaleDown,
                child: Text(
                  "${userData?.firstName ?? 'loading'} ${userData?.lastName ?? 'loading'}",
                  style: getSemiBoldStyle(
                    color: AppColors.white,
                    fontSize: FontSize.s20,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

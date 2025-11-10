import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExploreScreenProfileSection extends StatelessWidget {
  const ExploreScreenProfileSection({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        final userData =state.userData.data?.user?.personalInfo;
        return Skeletonizer(
          enabled:state.userData.isLoading,
           effect: ShimmerEffect(
                    baseColor: AppColors.gray[AppColors.colorCode70]!,
                    highlightColor: AppColors.gray[AppColors.colorCode40]!,
                  ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        "${context.loc.hiHomeText} ${userData?.firstName ?? ""},",
                        style: getMediumStyle(color: AppColors.white).copyWith(
                          fontSize: FontSize.s16,
                          fontFamily: 'BalooThambi2',
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        context.loc.letsStartDoingYourDay,
                        style: getBoldStyle(color: AppColors.white).copyWith(
                          fontSize: FontSize.s18,
                          fontFamily: 'BalooThambi2',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             ClipOval(
  child: SizedBox(
    width: context.setMinSize(36),
    height: context.setMinSize(36),
    child: CachedNetworkImage(
      imageUrl: userData?.photo ?? "",
      fit: BoxFit.cover,
      errorWidget: (_, __, ___) => const Icon(Icons.info),
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

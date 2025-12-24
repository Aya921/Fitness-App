import 'package:fitness/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import '../cubit/on_boarding_cubit.dart';
import '../cubit/on_boarding_state.dart';
import '../widget/on_boarding_bottom_section.dart';
import '../widget/page_builder.dart';
class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        final cubit = context.read<OnBoardingCubit>();
        final pageIndex = state.pageIndex;
        final isLastPage = pageIndex == cubit.images.length - 1;

        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                SizedBox.expand(
                  child: Image.asset(
                    AssetsManager.onBoardingBackGround,
                    fit: BoxFit.cover,
                  ),
                ),
                PageBuilder(images: cubit.images),
                Positioned(
                  top: context.setHight(40),
                  right: context.setWidth(16),
                  child: GestureDetector(
                    onTap: () {
                     Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
                    },
                    child: isLastPage
                        ? const SizedBox.shrink()
                        : Text(
                      Constants.skip,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: context.setSp(16),
                      ),
                    ),
                  ),
                ),
                OnBoardingBottomSection(
                  titles: cubit.titles,
                  images: cubit.images,
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}

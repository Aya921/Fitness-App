import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/custom_fitness_button.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/device_utils.dart';
import '../cubit/on_boarding_cubit.dart';
import '../cubit/on_boarding_intent.dart';
import '../cubit/on_boarding_state.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      AssetsManager.onBoardingImageOne,
      AssetsManager.onBoardingImageTwo,
      AssetsManager.onBoardingImageThree,
    ];

    final List<String> titles = [
      Constants.titleOnBoarding,
      Constants.titleTwoBoarding,
      Constants.titleThreeBoarding,
    ];

    final pageViewHeight = context.setHight(600);

    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        final cubit = context.read<OnBoardingCubit>();
        final pageIndex = state is PageChangedState ? state.pageIndex : 0;
        final isLastPage = pageIndex == images.length - 1;

        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                SizedBox.expand(
                  child: Image.asset(
                    AssetsManager.backGround,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: context.setHight(215),
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: pageViewHeight,
                    child: PageView.builder(
                      controller: cubit.pageController,
                      itemCount: images.length,
                      onPageChanged: (index) {
                        cubit.intent(PageChangedIntent(index));
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: context.setHight(79)),
                          child: Center(
                            child: SizedBox(
                              width: context.setWidth(390),
                              height: context.setHight(500),
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(context.setWidth(20)),
                                child: Image.asset(
                                  images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                  Positioned(
                    top: context.setHight(40),
                    right: context.setWidth(16),
                    child: GestureDetector(
                      onTap: () {
                        cubit.pageController.jumpToPage(images.length - 1);
                      },
                      child: Text(
                        Constants.skip,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: context.setSp(16),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: context.setHight(540),

                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(context.setWidth(30)),
                    ),

                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: context.setHight(275),
                        width: context.setWidth(375),
                        color: AppColors.black.withOpacity(0.3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: context.setHight(31)),
                              child: Text(
                                titles[pageIndex],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: context.setSp(
                                    DeviceUtils.valueDecider(
                                      context,
                                      onMobile: 24.0,
                                      onTablet: 28.0,
                                    )
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.setWidth(20),
                                vertical: context.setHight(8),
                              ),
                              child: Text(
                                Constants.descriptionOnBoarding,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: context.setSp(
                                    DeviceUtils.valueDecider(
                                      context,
                                      onMobile: 14.0,
                                      onTablet: 16.0,
                                      onDesktop: 18.0,
                                    ),
                                  ),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: context.setWidth(16), vertical: context.setHight(16)),
                              child: pageIndex == 0
                                  ? SizedBox(
                                width: double.infinity,
                                height: context.setHight(40),
                                child: CustomElevatedButton(
                                  onPressed: () {
                                    cubit.intent(NextPageIntent());
                                  },
                                  buttonTitle: Constants.next,
                                  titleStyle:  TextStyle(
                                    color: AppColors.white,
                                    fontSize: context.setSp(14) ,
                                  ),
                                ),
                              )
                                  : Row(
                                children: [
                                  SizedBox(
                                    width: context.setWidth(63),
                                    height: context.setHight(40),
                                    child: CustomElevatedButton(
                                      onPressed: () => cubit.pageController.previousPage(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      ),
                                      buttonTitle: Constants.skip,
                                      backgroundColor: Colors.transparent,
                                      borderColor: Theme.of(context).colorScheme.primary,
                                      titleStyle:  TextStyle(
                                        color: AppColors.white,
                                        fontSize: context.setSp(14),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  SmoothPageIndicator(
                                    count: images.length,
                                    controller: cubit.pageController,
                                    effect: const ExpandingDotsEffect(
                                      activeDotColor: AppColors.orange,
                                      dotHeight: 6,
                                      dotWidth: 6,
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: context.setWidth(63),
                                    height: context.setHight(40),
                                    child: CustomElevatedButton(
                                      onPressed: () {
                                        if (isLastPage) {
                                          /// TODO: Navigate to main screen
                                        } else {
                                          cubit.intent(NextPageIntent());
                                        }
                                      },
                                      buttonTitle: isLastPage ? Constants.doIt : Constants.next,
                                      titleStyle: TextStyle(
                                        color: AppColors.white,
                                        fontSize: context.setSp(14)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                            ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

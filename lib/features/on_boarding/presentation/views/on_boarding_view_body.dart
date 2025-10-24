import 'dart:ui';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/assets_manager.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widget/custom_fitness_button.dart';
import '../cubit/on_boarding_cubit.dart';
import '../cubit/on_boarding_intent.dart';
import '../cubit/on_boarding_state.dart';


class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override Widget build(BuildContext context) {
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
    final pageViewHeight = MediaQuery.of(context).size.height * 0.7;

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
                  bottom: 215,
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
                          padding: const EdgeInsets.only(top: 79),
                          child: Center(
                            child: SizedBox(
                              width: 390,
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
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
                if (!isLastPage)
                  Positioned(
                    top: 40,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        // cubit.pageController.jumpToPage(images.length - 1);
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute,(route) => false,);

                      },
                      child: const Text(
                        Constants.skip,
                        style: TextStyle(color: AppColors.white, fontSize: 16),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 565,
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: 275,
                        width: 375,
                        color: AppColors.black.withOpacity(0.3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 31),
                              child: Text(
                                titles[pageIndex],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                Constants.descriptionOnBoarding,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SmoothPageIndicator(
                              count: images.length,
                              controller: cubit.pageController,
                              effect: const ExpandingDotsEffect(
                                activeDotColor: AppColors.orange,),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              child: pageIndex > 0
                                  ? Row(
                                children: [
                                  SizedBox(
                                    width: 63,
                                    height: 40,
                                    child: CustomElevatedButton(
                                      onPressed: () => cubit.pageController.previousPage(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      ),
                                      buttonTitle: Constants.skip,
                                      backgroundColor: Colors.transparent,
                                      borderColor: Theme.of(context).colorScheme.primary,
                                      titleStyle: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: 40,
                                    width: 63,
                                    child: CustomElevatedButton(
                                      titleStyle: const TextStyle(
                                        color: AppColors.white
                                      ),
                                      onPressed: () {
                                        if (isLastPage) {
                                          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute,(route) => false,);
                                        } else {
                                          cubit.intent(
                                            NextPageIntent(),
                                          );
                                        }
                                      },
                                      buttonTitle: isLastPage ? Constants.doIt : Constants.next,
                                    ),
                                  ),
                                ],
                              )
                                  : CustomElevatedButton(
                                titleStyle: const TextStyle(
                                  color: AppColors.white,),
                                onPressed: () {
                                  cubit.intent(NextPageIntent());
                                },
                                buttonTitle: Constants.next,
                              ),
                            )
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

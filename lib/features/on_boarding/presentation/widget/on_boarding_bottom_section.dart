import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/custom_fitness_button.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/device_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../cubit/on_boarding_cubit.dart';
import '../cubit/on_boarding_intent.dart';
import '../cubit/on_boarding_state.dart';
import 'discretion_section.dart';

class OnBoardingBottomSection extends StatelessWidget {
  final List<String> titles;
  final List<String> images;

  const OnBoardingBottomSection({
    super.key,
    required this.titles,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        final cubit = context.read<OnBoardingCubit>();
        final pageIndex = state.pageIndex;
        final isLastPage = pageIndex == images.length - 1;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(context.setWidth(30)),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: double.infinity,
                    color: AppColors.black.withOpacity(0.3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: context.setHight(31)),
                          child: Text(
                            cubit.titles[pageIndex],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: context.setSp(
                                DeviceUtils.valueDecider(
                                  context,
                                  onMobile: 24.0,
                                  onTablet: 28.0,
                                ),
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const DiscretionSection(),
                        SizedBox(height: context.setHight(16)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.setWidth(16)),
                          child: pageIndex == 0
                              ? SizedBox(
                            width: double.infinity,
                            height: context.setHight(50),
                            child: CustomElevatedButton(
                              onPressed: () {
                                cubit.intent(NextPageIntent());
                              },
                              buttonTitle: Constants.next,
                              titleStyle: TextStyle(
                                color: AppColors.white,
                                fontSize: context.setSp(
                                  DeviceUtils.valueDecider(
                                    context,
                                    onMobile: 14.0,
                                    onTablet: 16.0,
                                  ),
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                              : Row(
                            children: [
                              SizedBox(
                                width: context.setWidth(63),
                                height: context.setHight(50),
                                child: CustomElevatedButton(
                                  onPressed: () => cubit.intent(PreviousPageIntent()),
                                  buttonTitle: Constants.skip,
                                  backgroundColor: Colors.transparent,
                                  borderColor:
                                  Theme.of(context).colorScheme.primary,
                                  titleStyle: TextStyle(
                                    color: AppColors.white,
                                    fontSize: context.setSp(
                                      DeviceUtils.valueDecider(
                                        context,
                                        onMobile: 14.0,
                                        onTablet: 16.0,
                                      ),
                                    ),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SmoothPageIndicator(
                                count: images.length,
                                controller: cubit.controller(),
                                axisDirection: Axis.horizontal,
                                effect: const ExpandingDotsEffect(
                                  activeDotColor: AppColors.orange,
                                  dotHeight: 6,
                                  dotWidth: 6,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: context.setWidth(63),
                                height: context.setHight(50),
                                child: CustomElevatedButton(
                                  onPressed: () {
                                    if (isLastPage) {
                                    /// xxxxxxxxxxxxxxxx  /// TODO: Navigate to main screen////xxxxxxxxxxxxxx
                                    } else {
                                      cubit.intent(NextPageIntent());
                                    }
                                  },
                                  buttonTitle: isLastPage
                                      ? Constants.doIt
                                      : Constants.next,
                                  titleStyle: TextStyle(
                                    color: AppColors.white,
                                    fontSize: context.setSp(
                                      DeviceUtils.valueDecider(
                                        context,
                                        onMobile: 14.0,
                                        onTablet: 16.0,
                                      ),
                                    ),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.setHight(16)),
                      ],
                    ),
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

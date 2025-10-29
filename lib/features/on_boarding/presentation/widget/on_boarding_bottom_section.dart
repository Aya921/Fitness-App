import 'dart:ui';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/custom_fitness_button.dart';
import 'package:fitness/core/responsive/size_helper.dart';
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
                                getTitle(context, pageIndex),
                            textAlign: TextAlign.center,
                            style: getExtraBoldStyle(color: AppColors.white)
                                  .copyWith(fontSize: FontSize.s24),
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
                              buttonTitle: context.loc.next,
                              titleStyle: getExtraBoldStyle(color: AppColors.lightWhite)
                                  .copyWith(fontSize: FontSize.s14),
                            ),
                          )
                              : Row(
                            children: [
                              SizedBox(
                                width: context.setWidth(63),
                                height: context.setHight(50),
                                child: CustomElevatedButton(
                                  onPressed: () => cubit.intent(PreviousPageIntent()),
                                  buttonTitle: context.loc.back,
                                  backgroundColor: Colors.transparent,
                                  borderColor:
                                  Theme.of(context).colorScheme.primary,
                                  titleStyle: getExtraBoldStyle(color: AppColors.lightWhite)
                                  .copyWith(fontSize: FontSize.s14),
                                ),
                              ),
                              const Spacer(),
                              SmoothPageIndicator(
                                count: images.length,
                                controller: cubit.controller(),
                                axisDirection: Axis.horizontal,
                                effect:  ExpandingDotsEffect(
                                  activeDotColor: AppColors.orange,
                                  dotHeight: context.setHight(6),
                                  dotWidth: context.setWidth(6),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: context.setWidth(63),
                                height: context.setHight(50),
                                child: CustomElevatedButton(
                                  onPressed: () {
                                    if (isLastPage) {
                                    Navigator.pushReplacementNamed(context,AppRoutes.loginRoute);
                                    } else {
                                      cubit.intent(NextPageIntent());
                                    }
                                  },
                                  buttonTitle: isLastPage
                                      ? context.loc.doIt
                                      : context.loc.next,
                                  titleStyle:getExtraBoldStyle(color: AppColors.lightWhite)
                                  .copyWith(fontSize: FontSize.s14),
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
String getTitle(BuildContext context, int index) {
  if (index == 0) return context.loc.onBoardingtitleOne;
  if (index == 1) return context.loc.onBoardingtitletwo;
  return context.loc.onBoardingtitlethree;
}
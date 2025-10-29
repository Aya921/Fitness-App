import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';

class DiscretionSection extends StatelessWidget {
  const DiscretionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        final pageIndex = state.pageIndex;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.setWidth(20),
            vertical: context.setHight(8),
          ),
          child: Text(
            getDescription(context, pageIndex),
            textAlign: TextAlign.center,
            style: getRegularStyle(color: AppColors.shadeWhite)
                                  .copyWith(fontSize: FontSize.s16),
          ),
        );
      },
    );
  }
}
String getDescription(BuildContext context, int index) {
  if (index == 0) return context.loc.onBoardingdescriptionOne;
  if (index == 1) return context.loc.onBoardingdescriptionTwo;
  return context.loc.onBoardingdescriptionThree;
}

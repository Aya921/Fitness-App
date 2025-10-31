import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/widget/tab_bar_widget.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_recommendation_list_item.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_upcoming_list_item.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreUpcomingListView extends StatelessWidget {
 const ExploreUpcomingListView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit,ExploreState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    context.loc.upcomingWorkOutsText,
                    style: getSemiBoldStyle(color: AppColors.white).copyWith(
                      fontSize: FontSize.s16,
                      fontFamily: 'BalooThambi2',
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    context.loc.seeAllHomeText,
                    style: getRegularStyle(color: AppColors.orange).copyWith(
                      fontSize: FontSize.s14,
                      fontFamily: 'BalooThambi2',
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.orange,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.setHight(8)),
            SizedBox(
              height: context.setHight(30),
              child: TabBarWidget(titles:state.musclesGroupState.data
    ?.map((muscle) => muscle.name ?? '')
    .toList() ?? []),
            ),
            SizedBox(height: context.setHight(8)),
            SizedBox(
              height: context.setHight(80),
              child: ListView.builder(
                itemCount: state.musclesGroupState.data?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const  ExploreUpcomingListItem();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

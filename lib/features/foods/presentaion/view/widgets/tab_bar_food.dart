import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/tab_item_widget.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_cubit.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_intent.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/meals_categories.dart';

class TabBarFood extends StatefulWidget {
  const TabBarFood({
    super.key,
    required this.titles,
    required this.selecteIndex,
  });

  final int selecteIndex;

  final List<MealCategoryEntity> titles;

  @override
  State<TabBarFood> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarFood> {
  late int currindex;

  @override
  void initState() {
    super.initState();
    currindex = widget.selecteIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FoodCubit>().doIntent(
        intent: MealsByCategoriesIntent(
          widget.titles[currindex].strCategory,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.setHight(40),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return BlocListener<FoodCubit, FoodStates>(
            listener: (context, state) {},
            child: TabItemWidget(
              title: widget.titles[index].strCategory,
              isSelected: currindex == index,
              onTap: () {
                setState(() {
                  currindex = index;
                });


                context.read<FoodCubit>().doIntent(
                  intent: MealsByCategoriesIntent(
                    widget.titles[index].strCategory,
                  ),
                );


              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: context.setWidth(10));
        },
        itemCount: widget.titles.length,
      ),
    );
  }
}

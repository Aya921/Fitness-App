import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/tab_item_widget.dart';
import 'package:fitness/features/food/domain/entities/meals_categories.dart';
import 'package:flutter/material.dart';

class TabBarFood extends StatefulWidget {
  const TabBarFood({super.key, required this.titles});

  final List<MealCategoryEntity> titles;

  @override
  State<TabBarFood> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarFood> {
  int selecteIndex = 0;

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
      height: context.setHight(40),
      child:   ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return TabItemWidget(
            title: widget.titles[index].strCategory,
            isSelected: selecteIndex == index,
            onTap: () {
              selecteIndex = index;
              setState(() {});
            },
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

import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/tab_item_widget.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key, required this.titles});

  final List<String> titles;

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  int selecteIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return TabItemWidget(
          title: widget.titles[index],
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
    );
  }
}

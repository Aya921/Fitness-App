import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/tab_item_widget.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({
    super.key,
    required this.titles,
    this.initialSelectedIndex = 0,
    this.onTabSelected,
     this.onTabChanged
  });

  final List<String> titles;
  final Function(int)? onTabChanged;
  final int initialSelectedIndex;
  final ValueChanged<int>? onTabSelected;

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return TabItemWidget(
          title: widget.titles[index],
          isSelected: selectedIndex == index,
          onTap: () {
            setState(() => selectedIndex = index);
            widget.onTabSelected?.call(index);
            widget.onTabChanged!(index);
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

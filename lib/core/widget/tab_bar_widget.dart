import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/tab_item_widget.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({
    super.key,
    required this.titles,
    this.initialSelectedIndex = 0,
    this.onTabSelected,
<<<<<<< HEAD
     this.onTabChanged
  });

  final List<String> titles;
  final Function(int)? onTabChanged;
  final int initialSelectedIndex;
  final ValueChanged<int>? onTabSelected;
=======
  });

  final List<String> titles;
  final int initialSelectedIndex;
  final ValueChanged<int>? onTabSelected; // 👈 هنا
>>>>>>> origin/feature/FA-13-Workouts

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
<<<<<<< HEAD
            widget.onTabChanged?.call(index);
=======
>>>>>>> origin/feature/FA-13-Workouts
          },
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(width: context.setWidth(10)),
      itemCount: widget.titles.length,
   );
  }
<<<<<<< HEAD
}
=======
}

>>>>>>> origin/feature/FA-13-Workouts

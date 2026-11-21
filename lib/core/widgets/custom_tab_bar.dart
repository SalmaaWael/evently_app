import 'package:evently_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'category_item.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.categories,
    required this.selectedBackgroundColor,
    required this.unselectedBackgroundColor,
    required this.selectedForegroundColor,
    required this.unselectedForegroundColor,
    required this.onTabChanged,
  });

  final List<CategoryModel> categories;
  final Color selectedBackgroundColor;
  final Color unselectedBackgroundColor;
  final Color selectedForegroundColor;
  final Color unselectedForegroundColor;
  final Function(int) onTabChanged;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int isSelectedIndexTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        indicatorColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            isSelectedIndexTab = index;
            widget.onTabChanged(index);
          });
        },
        isScrollable: true,
        tabs: widget.categories.map((category) {
          return CategoryItem(
            category: category,
            selectedBackgroundColor: widget.selectedBackgroundColor,
            unselectedBackgroundColor: widget.unselectedBackgroundColor,
            selectedForegroundColor: widget.selectedForegroundColor,
            unselectedForegroundColor: widget.unselectedForegroundColor,
            isSelected: isSelectedIndexTab == widget.categories.indexOf(category),
          );
        }).toList(),
      ),
    );
  }
}
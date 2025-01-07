import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class CustomTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController controller;
  final TabAlignment alignment;
  final bool isScrollable;
  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.controller,
    required this.alignment,
    required this.isScrollable,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: isScrollable,
      tabAlignment: alignment,
      indicatorSize: TabBarIndicatorSize.tab,
      overlayColor: WidgetStatePropertyAll<Color>(
        AppColors.mainBlue.withValues(alpha: 0.2),
      ),
      indicator: BoxDecoration(
        border: Border.all(
          width: 2,
          color: AppColors.mainBlue,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      splashBorderRadius: BorderRadius.circular(24),
      tabs: tabs,
      controller: controller,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:lms_system/core/constants/fonts.dart';

import '../../../../core/constants/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final TabAlignment? alignment;
  final bool isScrollable;
  const CustomTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.alignment = TabAlignment.start,
    required this.isScrollable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      margin: EdgeInsets.only(bottom: 5),
      child: TabBar(
        dividerColor: Colors.transparent,
        // isScrollable: tabs.length <= 4 ? false : isScrollable,
        isScrollable: true, // Force scrollable for dynamic sizing
        // tabAlignment: tabs.length <= 4 ? TabAlignment.fill : alignment,
        tabAlignment: TabAlignment.center,
        // indicatorSize: TabBarIndicatorSize.tab,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: textTheme.labelLarge!.copyWith(
            letterSpacing: 0.5,
            fontFamily: "Inter",
            color: Colors.white,
            overflow: TextOverflow.ellipsis),
        overlayColor: WidgetStatePropertyAll<Color>(
          AppColors.mainBlue.withValues(alpha: 0.2),
        ),
        indicator: BoxDecoration(
          color: AppColors.mainBlue,
          border: Border.all(
            width: 2,
            color: AppColors.mainBlue,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        indicatorColor: Colors.white,
        labelColor: Colors.white,

        splashBorderRadius: BorderRadius.circular(8),
        tabs: tabs.map((tab) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.mainBlue,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: tab,
          );
        }).toList(),
        controller: controller,
      ),
    );
  }
}

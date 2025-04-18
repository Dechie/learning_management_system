import 'package:flutter/material.dart';
import 'package:lms_system/core/constants/enums.dart';
import 'package:lms_system/features/exams/model/exams_model.dart';

import '../../../../core/constants/app_colors.dart';

class ExamCoursesList extends StatelessWidget {
  final List<ExamCourse> courses;
  final Size parentSize;
  final ExamType examType;
  const ExamCoursesList({
    super.key,
    required this.courses,
    required this.parentSize,
    required this.examType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: parentSize.width,
      height: parentSize.height,
      child: ListView.separated(
        itemCount: courses.length +
            1, // +1 for the last widget which is just a sizedbox.
        itemBuilder: (_, index) {
          if (index == courses.length) {
            // this will return a sizedbox.
            return const SizedBox(height: 100);
          }
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: Colors.black87,
            child: ListTile(
              leading: Text(courses[index].title),
              trailing: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.mainBlue,
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, index) => const SizedBox(height: 10),
      ),
    );
  }
}

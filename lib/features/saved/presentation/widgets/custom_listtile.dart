import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_system/core/constants/app_colors.dart';
import 'package:lms_system/core/constants/app_ints.dart';
import 'package:lms_system/features/courses/provider/course_content_providers.dart';
import 'package:lms_system/features/courses/provider/current_course_id.dart';
import 'package:lms_system/features/shared/model/shared_course_model.dart';
import 'package:lms_system/features/shared/provider/course_subbed_provider.dart';
import 'package:lms_system/features/wrapper/provider/wrapper_provider.dart';

class ListTilewidget extends ConsumerWidget {
  final Course course;

  final TextTheme textTh;
  const ListTilewidget({
    super.key,
    required this.course,
    required this.textTh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.read(pageNavigationProvider.notifier);
    return GestureDetector(
      child: Card(
        elevation: 3,
        color: Colors.white,
        shadowColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          leading: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                height: 60,
                width: double.infinity,
                "${course.image}.jpg", //?? "",
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Image.asset(
                    fit: BoxFit.cover,
                    "assets/images/placeholder_16.png",
                    height: 60,
                    width: double.infinity,
                  );
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  // Show an error widget if the image failed to load
                  return Image.asset(
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      "assets/images/placeholder_16.png");
                },
              ),
            ),
          ),
          title: Text(course.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${course.topics} topics"),
            ],
          ),
          trailing: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: AppColors.mainBlue,
              maximumSize: const Size(40, 40),
              minimumSize: const Size(20, 20),
            ),
            onPressed: () {
              final courseIdController =
                  ref.watch(currentCourseIdProvider.notifier);
              courseIdController.changeCourseId(course.id);
              ref.read(courseChaptersProvider.notifier).fetchCourseChapters();

              // we need this one later on to check if the course has been subbed
              // after we see the screen with chapter content such as documents and videos.
              ref
                  .read(courseSubTrackProvider.notifier)
                  .changeCurrentCourse(course);

              debugPrint(
                  "current course: Course{ id: ${ref.read(courseSubTrackProvider).id}, title: ${ref.read(courseSubTrackProvider).title} }");
              pageController.navigateTo(
                nextScreen: AppInts.courseChaptersPageIndex,
                arguments: {
                  "previousScreenIndex": AppInts.homePageIndex,
                  "course": course,
                },
              );
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}

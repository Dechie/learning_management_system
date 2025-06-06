import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_system/core/common_widgets/async_error_widget.dart';
import 'package:lms_system/core/common_widgets/course_card_network.dart';
import 'package:lms_system/core/constants/app_colors.dart';
import 'package:lms_system/core/constants/app_ints.dart';
import 'package:lms_system/features/courses/provider/course_content_providers.dart';
import 'package:lms_system/features/courses/provider/current_course_id.dart';
import 'package:lms_system/features/courses/provider/search_field_provider.dart';
import 'package:lms_system/features/courses/provider/search_prov.dart';
import 'package:lms_system/features/shared/presentation/widgets/custom_search_bar.dart';
import 'package:lms_system/features/shared/provider/course_subbed_provider.dart';
import 'package:lms_system/features/wrapper/provider/wrapper_provider.dart';

class SearchCoursesScreen extends ConsumerStatefulWidget {
  const SearchCoursesScreen({super.key});

  @override
  ConsumerState<SearchCoursesScreen> createState() =>
      _SearchCoursesScreenState();
}

class _SearchCoursesScreenState extends ConsumerState<SearchCoursesScreen> {
  bool modifyingSearchField = false;
  @override
  Widget build(BuildContext context) {
    final searchNotifier = ref.watch(searchCoursesProvider.notifier);
    final searchApiState = ref.watch(searchCoursesProvider);
    var size = MediaQuery.sizeOf(context);
    var textTh = Theme.of(context).textTheme;

    var searchQueryState = ref.watch(searchFieldProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            searchNotifier.clearSearch();
            ref.read(searchFieldProvider.notifier).changeFieldText("");
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          "Search Courses",
          style: textTh.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.black87,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size(size.width, 40),
          child: Container(
            width: size.width,
            color: Colors.white,
            height: 48,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
              child: CustomSearchBar(
                hintText: "Search Courses",
                size: size,
                searchCallback: () async {
                  setState(() {
                    modifyingSearchField = false;
                  });
                  final query = ref.read(searchFieldProvider);
                  await searchNotifier.searchCourses(query);
                },
                onChangedCallback: (value) async {
                  setState(() {
                    modifyingSearchField = true;
                  });
                  ref
                      .read(searchFieldProvider.notifier)
                      .changeFieldText(value!);
                },
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, top: 8),
        child: searchApiState.when(
          data: (courses) {
            if (!modifyingSearchField &&
                searchQueryState.isNotEmpty &&
                courses.isEmpty) {
              return Center(
                child: Text(
                  "Sorry, no courses match your search. Try different keywords!",
                  textAlign: TextAlign.center,
                  style: textTh.bodyLarge!.copyWith(
                    color: AppColors.mainBlue,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                mainAxisExtent: 237,
              ),
              itemCount: courses.length,
              itemBuilder: (_, index) {
                final course = courses[index];
                return GestureDetector(
                  onTap: () {
                    final pageNavController =
                        ref.read(pageNavigationProvider.notifier);
                    final courseIdController =
                        ref.watch(currentCourseIdProvider.notifier);
                    courseIdController.changeCourseId(course.id);

                    ref
                        .read(courseChaptersProvider.notifier)
                        .fetchCourseChapters();
                    ref
                        .read(courseSubTrackProvider.notifier)
                        .changeCurrentCourse(course);

                    debugPrint(
                        "current course: Course{ id: ${ref.read(courseSubTrackProvider).id}, title: ${ref.read(courseSubTrackProvider).title} }");

                    pageNavController.navigateTo(
                      nextScreen: AppInts.courseChaptersPageIndex,
                      arguments: {"course": course},
                    );

                    Navigator.of(context).pop();
                  },
                  child: CourseCardNetworkImage(
                    mainAxisExtent: 237,
                    course: course,
                    onLike: () async {},
                    onBookmark: () async {},
                  ),
                );
              },
            );
          },
          error: (error, stack) => AsyncErrorWidget(
            errorMsg: error.toString(),
            callback: () {},
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: AppColors.mainBlue,
              strokeWidth: 5,
            ),
          ),
        ),
      ),
    );
  }
}

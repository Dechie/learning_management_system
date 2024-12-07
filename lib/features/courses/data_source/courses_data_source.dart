import 'package:lms_system/features/courses/data_source/course_detail_data_source.dart';

import '../../shared_course/model/chapter.dart';
import '../../shared_course/model/shared_course_model.dart';
import '../model/categories_sub_categories.dart';

class CourseDataSource {
  List<CourseCategory> fetchCourseFromGrade(
    CategoryType categoryType,
    Grade grade,
  ) {
    return categoriesData.where((catData) {
      return catData.grades.contains(grade) &&
          catData.categoryType == categoryType;
    }).toList();
  }

  List<Course> fetchCourses() {
    return [
      Course(
        title: "Web Design",
        desc: "web design",
        topics: 21,
        saves: 9,
        image: "web_design.png",
        saved: false,
        subscribed: true,
        chapters: [
          Chapter(
            name: "Chapter 2",
            title: "Introduction to Web Design",
            videos: [
              Video(title: "What is Web Design?", duration: "10:23"),
              Video(title: "Tools for Web Design", duration: "15:45"),
            ],
          ),
          Chapter(
            name: "Chapter 2",
            title: "HTML Basics",
            videos: [
              Video(title: "HTML Structure", duration: "12:34"),
              Video(title: "HTML Tags", duration: "18:50"),
            ],
          ),
        ],
      ),
      Course(
        title: "Marketing",
        desc: "web design",
        topics: 21,
        saves: 12,
        image: "marketing_course.png",
        saved: true,
        subscribed: false,
        chapters: [
          Chapter(
            name: "Chapter 2",
            title: "Introduction to Web Design",
            videos: [
              Video(title: "What is Web Design?", duration: "10:23"),
              Video(title: "Tools for Web Design", duration: "15:45"),
            ],
          ),
          Chapter(
            name: "Chapter 2",
            title: "HTML Basics",
            videos: [
              Video(title: "HTML Structure", duration: "12:34"),
              Video(title: "HTML Tags", duration: "18:50"),
            ],
          ),
        ],
      ),
      Course(
        title: "Applied Mathematics",
        desc: "web design",
        topics: 21,
        saves: 4,
        image: "applied_math.png",
        saved: true,
        subscribed: true,
        chapters: [
          Chapter(
            name: "Chapter 2",
            title: "Introduction to Web Design",
            videos: [
              Video(title: "What is Web Design?", duration: "10:23"),
              Video(title: "Tools for Web Design", duration: "15:45"),
            ],
          ),
          Chapter(
            name: "Chapter 2",
            title: "HTML Basics",
            videos: [
              Video(title: "HTML Structure", duration: "12:34"),
              Video(title: "HTML Tags", duration: "18:50"),
            ],
          ),
        ],
      ),
      Course(
        title: "Accounting",
        desc: "web design",
        topics: 21,
        saves: 7,
        image: "accounting_course.png",
        saved: false,
        subscribed: true,
        chapters: [
          Chapter(
            name: "Chapter 2",
            title: "Introduction to Web Design",
            videos: [
              Video(title: "What is Web Design?", duration: "10:23"),
              Video(title: "Tools for Web Design", duration: "15:45"),
            ],
          ),
          Chapter(
            name: "Chapter 2",
            title: "HTML Basics",
            videos: [
              Video(title: "HTML Structure", duration: "12:34"),
              Video(title: "HTML Tags", duration: "18:50"),
            ],
          ),
        ],
      ),
      Course(
        title: "Applied Mathematics",
        desc: "web design",
        topics: 21,
        saves: 7,
        image: "applied_math.png",
        saved: true,
        subscribed: true,
        chapters: [
          Chapter(
            name: "Chapter 2",
            title: "Introduction to Web Design",
            videos: [
              Video(title: "What is Web Design?", duration: "10:23"),
              Video(title: "Tools for Web Design", duration: "15:45"),
            ],
          ),
          Chapter(
            name: "Chapter 2",
            title: "HTML Basics",
            videos: [
              Video(title: "HTML Structure", duration: "12:34"),
              Video(title: "HTML Tags", duration: "18:50"),
            ],
          ),
        ],
      ),
      Course(
        title: "Accounting",
        desc: "web design",
        topics: 21,
        saves: 7,
        image: "accounting_course.png",
        saved: false,
        subscribed: true,
        chapters: [
          Chapter(
            name: "Chapter 2",
            title: "Introduction to Web Design",
            videos: [
              Video(title: "What is Web Design?", duration: "10:23"),
              Video(title: "Tools for Web Design", duration: "15:45"),
            ],
          ),
          Chapter(
            name: "Chapter 2",
            title: "HTML Basics",
            videos: [
              Video(title: "HTML Structure", duration: "12:34"),
              Video(title: "HTML Tags", duration: "18:50"),
            ],
          ),
        ],
      ),
    ];
  }
}

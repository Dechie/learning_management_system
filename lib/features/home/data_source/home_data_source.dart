import '../../shared_course/model/chapter.dart';
import '../../shared_course/model/shared_course_model.dart';

class HomeDataSource {
  List<Course> fetchCourses() {
    return [
      Course(
        title: "Web Design",
        desc: "web design",
        topics: 21,
        saves: 7,
        image: "web_design.png",
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
        saves: 7,
        image: "marketing_course.png",
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

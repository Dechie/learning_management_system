import 'package:flutter/material.dart';
import 'package:lms_system/features/auth/presentation/screens/login_screen.dart';
import 'package:lms_system/features/auth/presentation/screens/profile_add.dart';
import 'package:lms_system/features/auth/presentation/screens/register_screen.dart';
import 'package:lms_system/features/courses/model/categories_sub_categories.dart';
import 'package:lms_system/features/courses/presentation/screens/chapter_detail.dart';
import 'package:lms_system/features/courses/presentation/screens/courses_per_category_list.dart';
import 'package:lms_system/features/home/presentation/screens/home_screen.dart';
import 'package:lms_system/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:lms_system/features/profile/presentation/screens/profile_screen.dart';
import 'package:lms_system/features/saved/presentation/screens/saved_screen.dart';
import 'package:lms_system/features/wrapper/presentation/screens/wrapper_screen.dart';
import 'package:lms_system/requests/presentation/screens/requests_screen.dart';

import '../features/courses/presentation/screens/courses_screen.dart';
import '../features/shared_course/model/chapter.dart';

class Approuter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.wrapper:
        return MaterialPageRoute(builder: (_) => WrapperScreen());

      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case Routes.profileAdd:
        return MaterialPageRoute(builder: (_) => const ProfileAddScreen());

      case Routes.courses:
        return MaterialPageRoute(builder: (_) => const CoursePage());

      case Routes.requests:
        return MaterialPageRoute(builder: (_) => const RequestsScreen());
      case Routes.courseDetails:
        final category = settings.arguments as CourseCategory;
        return MaterialPageRoute(
          builder: (_) => CoursesPerCategoryListPage(
            category: category,
          ),
        );
      case Routes.chapterDetails:
        final chapter = settings.arguments as Chapter;
        return MaterialPageRoute(
          builder: (_) => ChapterDetailPage(
            chapter: chapter,
          ),
        );

      case Routes.saved:
        return MaterialPageRoute(builder: (_) => const SavedCoursesPage());

      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      // case Routes.signUp:
      //   final prevRoute = settings.arguments as String;
      //   return MaterialPageRoute(
      //     builder: (_) => SignUpPage(
      //       previousRoute: prevRoute,
      //     ),
      //   );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}

class Routes {
  static const String wrapper = "wrapper";
  static const String onboarding = "onboarding";
  static const String home = "home";
  static const String login = "login";
  static const String profileAdd = "profile_add";
  static const String signup = "signup";
  static const String courses = "courses";
  static const String courseDetails = "courseDetails";
  static const String chapterDetails = "chapterDetails";
  static const String saved = "saved";
  static const String requests = "requests";
  static const String profile = "profile";
}

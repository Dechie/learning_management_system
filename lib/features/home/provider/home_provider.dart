import 'package:lms_system/features/home/repository/home_repository.dart';
import 'package:riverpod/riverpod.dart';

import '../../shared/model/shared_course_model.dart';


final pageviewPartsProvider = Provider<Map<String, String>>((ref) {
  return {
    "tag": "What would you like to learn today ?",
    "img": "online_course1.png"
  };
});

class HomeNotifier extends StateNotifier<AsyncValue<List<Course>>> {
  final HomeRepository repository;

  HomeNotifier(this.repository) : super(const AsyncLoading()) {
    loadData();
  }

  Future<void> loadData() async {
    try {
      state = const AsyncLoading();
      final courses = await repository.getCourses();
      state = AsyncData(courses);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  void toggleLiked(Course course) {
    state = state.whenData((courses) {
      return courses.map((c) {
        if (c == course) {
          return Course(
            id: c.id,
            title: c.title,
            category: c.category,
            topics: c.topics,
            saves: c.saves,
            likes: c.likes + (c.liked ? -1 : 1),
            liked: !c.liked,
            image: c.image,
            saved: c.saved,
            subscribed: c.subscribed,
            price: c.price,
            chapters: c.chapters,
          );
        }
        return c;
      }).toList();
    });
  }

  void toggleSaved(Course course) {
    state = state.whenData((courses) {
      return courses.map((c) {
        if (c == course) {
          return Course(
            id: c.id,
            title: c.title,
            category: c.category,
            topics: c.topics,
            saves: c.saves + (c.saved ? -1 : 1),
            likes: c.likes,
            liked: c.liked,
            image: c.image,
            saved: !c.saved,
            subscribed: c.subscribed,
            price: c.price,
            chapters: c.chapters,
          );
        }
        return c;
      }).toList();
    });
  }

  void toggleSubscribed(Course course) {
    state = state.whenData((courses) {
      return courses.map((c) {
        if (c == course) {
          return Course(
            id: c.id,
            title: c.title,
            category: c.category,
            topics: c.topics,
            saves: c.saves,
            likes: c.likes,
            liked: c.liked,
            image: c.image,
            saved: c.saved,
            subscribed: !c.subscribed,
            price: c.price,
            chapters: c.chapters,
          );
        }
        return c;
      }).toList();
    });
  }
}

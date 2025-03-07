import 'dart:math';

import 'package:lms_system/core/constants/enums.dart';
import 'package:lms_system/features/exams/model/exams_model.dart';

class ExamYear {
  final String title;
  final int id, courseId, questionCount;
  final List<Question> questions; // For non-matric exams
  final List<ExamGrade> grades; // For matric exams
  bool subscribed;

  final Map<SubscriptionType, double> price;
  Map<SubscriptionType, double?> onSalePrices;

  ExamYear({
    required this.id,
    required this.courseId,
    required this.title,
    this.questions = const [],
    this.subscribed = false,
    required this.price,
    this.onSalePrices = const {},
    this.questionCount = 0,
    this.grades = const [],
  });

  factory ExamYear.fromJson(Map<String, dynamic> json) {
    Map<SubscriptionType, double?> onSalePrices = {
      SubscriptionType.oneMonth: null,
      SubscriptionType.threeMonths: null,
      SubscriptionType.sixMonths: null,
      SubscriptionType.yearly: null,
    };
    if (json["on_sale_one_month"] != null) {
      onSalePrices[SubscriptionType.oneMonth] =
          double.tryParse(json["on_sale_one_month"]);
    }
    if (json["on_sale_three_month"] != null) {
      onSalePrices[SubscriptionType.threeMonths] =
          double.tryParse(json["on_sale_three_month"]);
    }
    if (json["on_sale_six_month"] != null) {
      onSalePrices[SubscriptionType.sixMonths] =
          double.tryParse(json["on_sale_six_month"]);
    }
    if (json["on_sale_one_year"] != null) {
      onSalePrices[SubscriptionType.yearly] =
          double.tryParse(json["on_sale_one_year"]);
    }

    List<bool> vals = [true, false];
    int randomIndex = Random().nextInt(2);
    bool subbed = vals[randomIndex];
    return ExamYear(
      id: json["id"] ?? 0,
      title: json["year_name"] ?? "year name",
      courseId: json["course_id"] ?? 0,
      questionCount: json['exam_questions_count'] ?? 0,
      // price: {
      //   SubscriptionType.oneMonth:
      //       double.tryParse(json["price_one_month"] ?? 0) ?? 0,
      //   SubscriptionType.threeMonths:
      //       double.tryParse(json["price_three_month"] ?? 0) ?? 0,
      //   SubscriptionType.sixMonths:
      //       double.tryParse(json["price_six_month"] ?? 0) ?? 0,
      //   SubscriptionType.yearly:
      //       double.tryParse(json["price_one_year"] ?? 0) ?? 0,
      // },
      price: {},
      subscribed: subbed,
    );
  }
  factory ExamYear.initial() {
    return ExamYear(
      id: -1,
      courseId: -1,
      title: "",
      price: {},
    );
  }

  double getPriceBySubscriptionType(SubscriptionType subscriptionType) {
    double priceValue =
        onSalePrices[subscriptionType] ?? price[subscriptionType]!;
    return priceValue;
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_system/core/constants/enums.dart';
import 'package:lms_system/core/utils/error_handling.dart';
import 'package:lms_system/features/exams/model/exam_year.dart';
import 'package:lms_system/features/shared/model/api_response_model.dart';
import 'package:lms_system/features/subscription/repository/exams_subscription_repository.dart';

import '../../model/exam_subscription_model.dart';

final examSubscriptionControllerProvider =
    StateNotifierProvider<ExamsSubscriptionController, ExamSubscriptionModel>(
        (ref) {
  return ExamsSubscriptionController(
      ref.watch(examsSubscriptionRepositoryProvider));
});

class ExamsSubscriptionController extends StateNotifier<ExamSubscriptionModel> {
  final ExamsSubscriptionRepository _repository;
  ExamsSubscriptionController(this._repository)
      : super(ExamSubscriptionModel());

  Future<ApiResponse> subscribe() async {
    String statusMsg = "";
    bool statusBool = false;
    Response? response;
    int? statusCode;

    try {
      debugPrint(
          "in exam sub provider: current exam sheets: [${state.examYears.map((yr) => yr.examSheetId).toList().join(",")}]");
      state = state.copyWith(apiState: ApiState.busy);

      response = await _repository.subscribe(state);
      statusCode = response.statusCode;
      debugPrint(response.data["message"]);

      state = state.copyWith(
        statusMsg: response.data["message"] ?? "An Error Occurred.",
        statusSuccess: response.data["status"] ?? false,
      );
      if (response.statusCode == 201) {
        //debugPrint("status 201 case");
        state = state.copyWith(
          statusMsg: response.data["message"],
          statusSuccess: response.data["status"],
          apiState: ApiState.idle,
        );
      } else if (response.statusCode == 400) {
        //debugPrint("status 400 case");
        state = state.copyWith(
          statusMsg: response.data["message"],
          statusSuccess: response.data["status"],
          apiState: ApiState.error,
        );
      }
    } catch (e) {
      //debugPrint("exception case");

      state = state.copyWith(
        statusMsg:
            ApiExceptions.getExceptionMessage(e as Exception, statusCode),
        statusSuccess: response?.data["status"] ?? false,
        apiState: ApiState.error,
      );
    }
    return ApiResponse(
        message: state.statusMessage, responseStatus: state.statusSuccess);
  }

  void updateExams(List<ExamYear> newExamYears) {
    debugPrint(
        "before update examYears: examyears length: ${state.examYears.length}");
    state = state.copyWith(newExamYears: newExamYears);
    debugPrint(
        "after update examYears: examyears length: ${state.examYears.length}");
  }

  void updateExamType(ExamType examType) {
    state = state.copyWith(examType: examType);
  }

  void updateScreenshotPath(String imagePath) {
    state = state.copyWith(newImagePath: imagePath);
  }

  void updateSubscriptionType(SubscriptionType newType) {
    state = state.copyWith(newType: newType);
  }

  void updateTransactionId(String newTransactionId) {
    state = state.copyWith(newTransactionId: newTransactionId);
  }
}

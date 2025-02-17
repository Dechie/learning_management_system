import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_system/core/utils/db_service.dart';
import 'package:lms_system/core/utils/dio_client.dart';
import 'package:lms_system/core/utils/error_handling.dart';
import 'package:lms_system/core/utils/storage_service.dart';
import 'package:lms_system/features/subscription/model/subscription_model.dart';

final subscriptionDataSourceProvider = Provider<SubscriptionDataSource>((ref) {
  return SubscriptionDataSource(DioClient.instance);
});

class SubscriptionDataSource {
  final Dio _dio;
  SubscriptionDataSource(this._dio);

  Future<Response> subscribe(SubscriptionModel request) async {
    FormData formData = await request.toFormData();
    int? statusCode;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("➡️ Request: ${options.method} ${options.uri}");
          debugPrint("Headers: ${options.headers}");
          debugPrint("Body: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("✅ Response: ${response.statusCode}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint("❌ Error: ${e.response?.statusCode}");
          debugPrint("Message: ${e.response?.data}");
          return handler.next(e);
        },
      ),
    );

    //var user = await DatabaseService().getUserFromDatabase();
      var user = await SecureStorageService().getUserFromStorage();
    var token = user?.token;

    if (token != null) {
      DioClient.setToken(token);
    }

    debugPrint("➡️ Request: POST /subscription-request");
    debugPrint("Headers: ${_dio.options.headers}");
    debugPrint("Body: ${formData.fields}");
    try {
      _dio.options.headers['Content-Type'] = 'multipart/form-data';
      final response = await _dio.post(
        "/subscription-request",
        data: formData,
      );
      statusCode = response.statusCode;
      return response;
    } on DioException catch (e) {
      String errorMessage = ApiExceptions.getExceptionMessage(e, statusCode);
      throw Exception(errorMessage);
    }
  }
}

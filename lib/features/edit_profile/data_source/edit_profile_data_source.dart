import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_system/core/constants/app_urls.dart';
import 'package:lms_system/core/utils/dio_client.dart';
import 'package:lms_system/core/utils/error_handling.dart';
import 'package:lms_system/core/utils/storage_service.dart';
import 'package:lms_system/features/shared/model/shared_user.dart';

final editProfileDataSourceProvider = Provider<EditProfileDataSource>(
    (ref) => EditProfileDataSource(DioClient.instance, SecureStorageService()));

class EditProfileDataSource {
  final Dio _dio;
  final SecureStorageService _storageService;

  EditProfileDataSource(this._dio, this._storageService);

  Future<Response> editUserProfile(
    User user,
  ) async {
    int? statusCode;
    FormData formData = await user.toFormData();

    debugPrint("client token: [${_dio.options.headers["Authorization"]}]");
    await DioClient.setToken();
    try {
      _dio.options.headers['Content-Type'] = 'multipart/form-data';
      _dio.options.headers['Accept'] = 'application/json';
      final response = await _dio.post(
        AppUrls.editProfile,
        data: formData,
      );
      debugPrint(response.data["data"]["user"]["password"]);
      debugPrint(response.data["data"]["user"]["email"]);
      statusCode = response.statusCode;
      await _storageService.saveUserToStorage(user);
      return response;
    } on DioException catch (e) {
      String errorMessage = ApiExceptions.getExceptionMessage(e, statusCode);
      throw Exception(errorMessage);
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_system/core/utils/connectivity/connectivity_service.dart';
import 'package:lms_system/features/forgot_password/data_source/forgot_password_data_source.dart';

final forgotPasswordRepositoryProvider =
    Provider<ForgotPasswordRepository>((ref) {
  return ForgotPasswordRepository(
    ref.watch(forgotPasswordDataSourceProvider),
    ref.watch(connectivityServiceProvider),
  );
});

class ForgotPasswordRepository {
  final ForgotPasswordDataSource _dataSource;
  final ConnectivityService _connectivityService;

  ForgotPasswordRepository(this._dataSource, this._connectivityService);

  Future<void> resetPassword() async {
    if (!await _connectivityService.hasConnection()) {
      throw Exception("No internet connection");
    }
    return await _dataSource.resetPassword();
  }
}

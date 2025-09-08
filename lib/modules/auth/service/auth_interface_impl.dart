import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/failure.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/core/services/network/auth/auth_service.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/interface/auth_inerface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/model/login_entity.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/model/reset_password_param.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/model/signup_param.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/model/verify_account_param.dart';

import '../../../core/helpers/format_response_data.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';

final class AuthInterfaceImpl extends AuthInterface{
  final ApiClient apiClient;
  final AuthService authService;

  AuthInterfaceImpl(this.apiClient, this.authService);

  @override
  Stream<AuthStatus?> authStream() {
    return authService.authStream;
  }

  @override
  bool isFirstTimeInstall() {
    // TODO: implement isFirstTimeInstall
    throw UnimplementedError();
  }

  @override
  FutureRequest<Success> login(LoginRequestParams params) async{
    return await asyncTryCatch(tryFunc: () async{
      final response = await apiClient.get(ApiEndpoints.getCurrentProfile);
      
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> logout() async{
    return asyncTryCatch(tryFunc: () async{
      await authService.clearCurrentAuthRecord();
      return Success(message: "Successful logout.");
    });
  }

  @override
  void setFirstTimeInstall() {
    // TODO: implement setFirstTimeInstall
  }

  @override
  FutureRequest<Success> signup(SignupParam params) async{
    return await asyncTryCatch(tryFunc: () async{
      debugPrint(params.toJson().toString());
      final response = await apiClient.post(
        ApiEndpoints.signup,
        data: params.toJson(),
      );
      return Success(message: extractSuccessMessage(response));
    });
  }

  @override
  FutureRequest<Success> forgetPassword(String email) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  FutureRequest<Success> resetPassword(ResetPasswordParam params) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  FutureRequest<Success> verifyAccount(VerifyAccountParam params) async{
    
    debugPrint(params.toMap().toString());
    return await asyncTryCatch(tryFunc: () async{
      final response = await apiClient.post(
        ApiEndpoints.registerVerify,
        data: params.toMap(),
      );
      return Success(message: extractSuccessMessage(response));
    });
  }

}
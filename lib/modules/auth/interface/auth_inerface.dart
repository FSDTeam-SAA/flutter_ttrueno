import 'package:dartz/dartz.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/failure.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/trycatch.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/model/create_new_password_param.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/model/reset_password_param.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/model/signup_param.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/model/verify_account_param.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/model/verify_otp_param.dart';

import '../../../../core/services/network/auth/auth_service.dart';
import '../model/forget_password_param.dart';
import '../model/login_entity.dart';

 abstract base class AuthInterface extends Repository{
  FutureRequest<Success> login(LoginRequestParams params);
  FutureRequest<Success> signup(SignupParam params);
  /// Verify account
  FutureRequest<Success> verifyAccount(VerifyAccountParam params);
  Stream<AuthStatus?> authStream();

  FutureRequest<Success> forgetPassword(ForgetPasswordParam email);

  FutureRequest<Success> verifyCode(VerifyOtpParam param);

  FutureRequest<Success> createNewPassword(CreateNewPasswordParam params);
  
  Future<Either<DataCRUDFailure, Success>> logout();
  bool isFirstTimeInstall();
  void setFirstTimeInstall();
}

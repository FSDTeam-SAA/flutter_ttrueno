import 'package:dartz/dartz.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/failure.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';

import '../../../../core/services/network/auth/auth_service.dart';
import '../entity/login_entity.dart';

abstract class AuthRepo {
  Future<Either<DataCRUDFailure, Success>> login(LoginRequestParams params);
  Stream<AuthStatus?> authStream();

  Future<Either<DataCRUDFailure, Success>> logout();

  bool isFirstTimeInstall();
  void setFirstTimeInstall();
}

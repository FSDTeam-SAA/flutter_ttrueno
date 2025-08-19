import 'package:dartz/dartz.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/data/model/login_model.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../../../../core/services/network/auth/auth_service.dart';
import '../../domains/entity/login_entity.dart';
import '../../domains/repo/auth_repo.dart';

final class AuthRepoImpl with Repository implements AuthRepo {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepoImpl(this.remoteDatasource);

  @override
  Stream<AuthStatus?> authStream() {
    return remoteDatasource.authStream();
  }

  @override
  bool isFirstTimeInstall() {
    throw UnimplementedError();
  }

  @override
  Future<Either<DataCRUDFailure, Success>> login(
    LoginRequestParams params,
  ) async {
    return await asyncTryCatch(
      tryFunc: () async {
        return await remoteDatasource.login(
          params: LoginRequestModel.fromEntity(params),
        );
      },
    );
  }
  
  @override
  Future<Either<DataCRUDFailure, Success>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
  
  @override
  void setFirstTimeInstall() {
    // TODO: implement setFirstTimeInstall
  }
}

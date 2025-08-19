import 'package:dartz/dartz.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/base/usecases/usecases.dart';
import '../entity/login_entity.dart';
import '../repo/auth_repo.dart';

class Login implements AsyncEitherUsecase<Success, LoginRequestParams> {
  final AuthRepo authRepo;
  const Login(this.authRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(LoginRequestParams params) async {
    return await authRepo.login(params);
  }
}

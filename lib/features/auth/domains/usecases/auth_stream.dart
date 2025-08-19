
import '../../../../core/base/usecases/usecases.dart';
import '../../../../core/services/network/auth/auth_service.dart';
import '../repo/auth_repo.dart';

class AuthStream implements NormalUsecase<Stream<AuthStatus?>, NoParams>{
  final AuthRepo repo;

  AuthStream(this.repo);
  @override
  Stream<AuthStatus?> call(NoParams params) {
    return repo.authStream();
  }
}
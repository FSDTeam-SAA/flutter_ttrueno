import 'package:ttrueno_fo827e642a0c4/features/auth/data/model/login_model.dart';

import '../../../../../core/api_handler/success.dart';
import '../../../../../core/helpers/dekhao.dart';
import '../../../../../core/helpers/format_response_data.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/services/network/auth/auth_service.dart';


abstract interface class AuthRemoteDatasource {
  /// Return logout success message.
  Future<Success> logout();

  Future<Success> login({required LoginRequestModel params});

  /// Auth stream
  Stream<AuthStatus?> authStream();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiClient apiClient;
  final AuthService authService;

  AuthRemoteDatasourceImpl(this.apiClient, this.authService);

  @override
  Future<Success<NoData>> logout() async {
    await authService.clearCurrentAuthRecord();
    return Success(message: "Successful logout.", data: null);
  }

  @override
  Stream<AuthStatus?> authStream() {
    return apiClient.authStream;
  }

  @override
  Future<Success> login({required LoginRequestModel params}) async {
    dekhao2(params.toMap());
    dekhao2("Logging in with params: ${params.toMap()}");
    final response = await apiClient.post(
      ApiEndpoints.login,
      data: params.toMap(),
    );
    dekhao2("loginRespone $response");
    final responseModel = LoginResponseModel.fromMap(extractBodyData(response));
    await authService.saveNewAuth(
      userId: responseModel.userId,
      accessToken: responseModel.accessToken,
      refreshToken: responseModel.refreshToken,
    );
    return Success(message: extractSuccessMessage(response));
  }

}

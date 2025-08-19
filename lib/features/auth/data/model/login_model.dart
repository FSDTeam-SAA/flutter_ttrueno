
import '../../domains/entity/login_entity.dart';


class LoginResponseModel extends LoginResponse{
  LoginResponseModel({required super.userId, required super.accessToken, required super.refreshToken});
  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      userId: map['_id'] as String,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  factory LoginResponseModel.fromEntity(LoginResponse entity) {
    return LoginResponseModel(
      userId: entity.userId,
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': userId,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}

class LoginRequestModel extends LoginRequestParams {
  LoginRequestModel({required super.email, required super.password});

  factory LoginRequestModel.fromMap(Map<String, dynamic> map) {
    return LoginRequestModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  factory LoginRequestModel.fromEntity(LoginRequestParams entity) {
    return LoginRequestModel(
      email: entity.email,
      password: entity.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}

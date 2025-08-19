class LoginEntity {}

class LoginRequestParams extends LoginEntity {
  final String email;
  final String password;

  LoginRequestParams({required this.email, required this.password});
}

class LoginResponse extends LoginEntity {
  final String userId;
  final String accessToken;
  final String refreshToken;

  LoginResponse({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });
}

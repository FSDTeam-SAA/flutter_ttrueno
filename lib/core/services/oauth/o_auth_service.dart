import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:ttrueno_fo827e642a0c4/core/base/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/constants/api_endpoints.dart';
import 'package:ttrueno_fo827e642a0c4/core/services/app_pigeon/app_pigeon.dart';

import '../../utils/helpers/format_response_data.dart';

class OAuthService {
  OAuthService(this.appPigeon);
  final AppPigeon appPigeon;
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final String backendBaseUrl = ApiEndpoints.baseUrl;
  final String _googleClientId = const String.fromEnvironment('GOOGLE_CLIENT_ID', defaultValue: "GOOGLE_CLIENT_ID is not set");
  final String _redirectUrl = const String.fromEnvironment('REDIRECT_URL');
  
  /// Returns success message or throws error.
  Future<Success> loginWithGoogle() async {
    debugPrint("Login with google clientId : $_googleClientId");
    final AuthorizationTokenResponse result = await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        _googleClientId,
        _redirectUrl,
        serviceConfiguration: AuthorizationServiceConfiguration(
          authorizationEndpoint: 'https://accounts.google.com/o/oauth2/v2/auth',
          tokenEndpoint: 'https://oauth2.googleapis.com/token',
        ),
        scopes: ['openid', 'profile', 'email'],
      )
    );

    final idToken = result.idToken;
    final accessToken = result.accessToken;

    // Send idToken to backend for verification... and app JWt issuance..
    final resp = await appPigeon.post(
      ApiEndpoints.login,
      data: {
        "idToken": idToken,
        "accessToken": accessToken,
      }
    );

    /// parse accessToken and refressToken
    final body = extractBodyData(resp);
    await appPigeon.saveNewAuth(
      saveAuthParams: SaveNewAuthParams(
        uid: body["user"]["_id"] as String,
        accessToken: body["accessToken"] as String,
        refreshToken: body["user"]["refreshToken"] as String,
        data: {
          "userId": body["user"]["_id"] as String? ?? "",
        }
      ),
    );
    return Success(message: extractSuccessMessage(resp) ?? "Successfully logged in.");
  }
}
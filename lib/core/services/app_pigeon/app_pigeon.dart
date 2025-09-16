import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:ttrueno_fo827e642a0c4/core/helpers/auth_role.dart';
import '../debug/debug_service.dart';
import 'refresh_token_manager.dart';
part 'auth/auth_service.dart';
part 'auth/auth.dart';
part 'auth/auth_status.dart';
part 'auth/auth_storage.dart';
part 'socket/socket_service.dart';
part 'auth/auth_params.dart';

extension on Auth {
  SocketConnectParam? get socketConnectParam {
    return SocketConnectParam(token: _accessToken!, userId: userId);
  }
}

class AppPigeon {
  final Dio _dio;
  SocketService? _socketService;
  late final AuthService _authService;
  final FlutterSecureStorage _secureStorage;
  final RefreshTokenManagerInterface refreshTokenManager;
  final String baseUrl;
  ///provide the socket url, if you want to use the `listen()` method.
  final String? socketUrl;
  AppPigeon(
    this._dio,
    this._secureStorage,
    this.refreshTokenManager,
    {
      required this.baseUrl,
      this.socketUrl,
    }){
      // Set base url
      _dio.options.baseUrl = baseUrl;
      // Initializes and adds auth interceptor
      _authService = AuthService(_secureStorage, _dio, refreshTokenManager);
      _dio.interceptors.add(_authService);
      _init();
      
  }

  _init() {
    _authService.init();
    // If socket url is provided, initializes the socket service
      if(socketUrl != null) {
        _socketService = SocketService(_authService, socketUrl!);
      }
  }

  dispose() {
    _authService.dispose();
  }

  Stream<AuthStatus> get authStream => _authService.authStream;

  Future<void> saveNewAuth({required SaveNewAuthParams saveAuthParams}) async{
    await _authService.saveNewAuth(saveNewAuthParams: saveAuthParams);
  }

  Future<void> updateCurrentAuth({required UpdateAuthParams updateAuthParams}) async{
    await _authService.updateCurrentAuth(updateAuthParams: updateAuthParams);
  }

  Future<void> clearAllAuth() async{
    await _authService.clearCurrentAuthRecord();
  }

  // Public GET/POST/PUT/DELETE wrappers
  Future<Response> get(String path, {dynamic data, Map<String, dynamic>? query}) {
    return _dio.get(path, queryParameters: query, data: data);
  }

  Future<Response> post(String path, {dynamic data, Options? options}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data, Options? options,}) {
    return _dio.put(path, data: data, options: options);
  }

  Future<Response> patch(String path, {dynamic data, Options? options,}) {
    return _dio.patch(path, data: data, options: options);
  }

  Future<Response> delete(String path, {dynamic data, Options? options, Map<String, dynamic>? queryParameters}) {
    return _dio.delete(path, data: data, queryParameters: queryParameters);
  }

  Stream<dynamic> listen(String channelName) {

    if (socketUrl == null || _socketService == null) {
      throw Exception("You need to provide the socket url to use the `listen()` method.");
    }
    
    return _socketService!.listen(channelName); // forward events, not just yield the stream object
  }

}

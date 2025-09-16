part of '../app_pigeon.dart';

class SocketConnectParam {
  final String _token;
  final String _userId;

  SocketConnectParam({
    required String token,
    required String userId,
  }) : 
       _token = token,
       _userId = userId;
}

sealed class NetworkStatus {
  const NetworkStatus();
}

final class NetworkConnected extends NetworkStatus {
  const NetworkConnected();
}

final class NetworkDisconnected extends NetworkStatus {
  const NetworkDisconnected();
}

class SocketService {
  final Map<String, StreamController<dynamic>> _channels = {};
  io.Socket? _socket;
  final AuthService authService;
  final String socketUrl;
  final Debugger _debugger = AuthDebugger();

  SocketService(this.authService, this.socketUrl) {
    _listenToAuthChange();
  }

  SocketConnectParam? _param;

  void _listenToAuthChange() {
    // Listen's to auth changes
    authService.authStream.listen((status) {
      if (status is! Authenticated) {
        _debugger.dekhao("Status is! Authenticated.");
        _disposeSocket();
      } else {
        _param = status.auth.socketConnectParam;
      }
    });
  }

  Future<void> _init() async {
    if (_socket != null) {
      debugPrint("Socket already initialized. Not initializing again.");
      return;
    }

    if(_param == null) {
      return;
    }

    _socket = io.io(
      socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({'Authorization': 'Bearer ${_param!._token}'})
          .build(),
    );
    debugPrint("Socket connecting");
    _socket?.connect();
    _socket?.onConnect((data) {
      debugPrint("Socket connected");
      _socket?.emit("join", _param!._userId);
    });
  }

  Stream<dynamic> listen(String channelName,) {
    debugPrint("Listening to $channelName");
    if (_channels.containsKey(channelName)) {
      debugPrint("Already listening to $channelName");
      return _channels[channelName]!.stream;
    }
    
    final controller = StreamController<dynamic>.broadcast();
    _channels[channelName] = controller;

    _init().then((_) {
      _socket?.on(channelName, (data) {
        //debugPrint("Socket data: $data");
        controller.add(data);
      });
    });

    return controller.stream;
  }

  void stopListening(String channelName) {
    _socket?.off(channelName);
    _channels[channelName]?.close();
    _channels.remove(channelName);
  }

  void _disposeSocket() {
    _debugger.dekhao("Closing controllers and diposing socket...");
    for (var controller in _channels.values) {
      controller.close();
    }
    _channels.clear();
    _socket?.disconnect();
    _socket?.destroy();
    _socket = null;
  }
}


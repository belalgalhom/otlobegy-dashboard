import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/features/auth/data/auth_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SocketService {
  io.Socket? _socket;
  final String _baseUrl = 'https://ws.otlob-egy.online'; // Updated WebSocket URL

  Future<void> init({String? forceToken}) async {
    final authRepository = sl<AuthRepository>();
    
    // Check if token is expired or about to expire (5 min buffer)
    bool needsRefresh = await authRepository.isTokenExpired();
    if (!needsRefresh) {
      final token = await FlutterSecureStorage().read(key: 'access_token');
      if (token != null) {
        final remaining = JwtDecoder.getRemainingTime(token);
        if (remaining.inMinutes < 5) needsRefresh = true;
      }
    }

    if (needsRefresh) {
      print('🔄 Admin Socket: Token expiring soon, attempting refresh...');
      try {
        await authRepository.refreshToken();
        print('✅ Admin Socket: Token refreshed successfully');
      } catch (e) {
        print('❌ Admin Socket: Token refresh failed: $e');
      }
    }

    const storage = FlutterSecureStorage();
    final token = forceToken ?? await storage.read(key: 'access_token');
    
    if (token == null) return;

    // If already connected with the same token, don't re-init
    if (_socket != null && _socket!.connected) {
      return;
    }

    _socket?.dispose(); // Clean up old socket if any
    
    _socket = io.io(
      '$_baseUrl/events',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .setQuery({'token': token}) // Sometimes helpful for some server configs
          .build(),
    );

    _socket?.connect();
    
    _socket?.onConnect((_) => print('✅ Admin Socket connected'));
    
    _socket?.onConnectError((err) async {
      print('❌ Admin Socket Connect Error: $err');
      // If error is related to authentication, try to refresh and reconnect
      final errorStr = err.toString().toLowerCase();
      if (errorStr.contains('unauthorized') || errorStr.contains('expired') || errorStr.contains('auth')) {
        print('🔐 Admin Socket: Auth error detected, refreshing token...');
        try {
          await authRepository.refreshToken();
          init(); // Retry initialization with new token
        } catch (e) {
          print('❌ Admin Socket: Re-auth failed: $e');
        }
      }
    });

    _socket?.onDisconnect((_) => print('❌ Admin Socket disconnected'));
  }

  void on(String eventName, Function(dynamic) callback) =>
      _socket?.on(eventName, callback);

  void off(String eventName, [Function(dynamic)? callback]) => 
      _socket?.off(eventName, callback);

  void emit(String eventName, dynamic data) =>
      _socket?.emit(eventName, data);

  void connect() => _socket?.connect();

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }
}

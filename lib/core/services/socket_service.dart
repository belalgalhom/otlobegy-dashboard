import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/features/auth/data/auth_repository.dart';

class SocketService {
  io.Socket? _socket;
  final String _baseUrl = 'https://ws.otlob-egy.online'; // Updated WebSocket URL

  Future<void> init({String? forceToken}) async {
    final authRepository = sl<AuthRepository>();
    
    // Check if token is expired and refresh if needed
    if (await authRepository.isTokenExpired()) {
      print('🔄 Admin Socket: Token expired, attempting refresh...');
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
      // Check if we need to update the token (auth)
      return;
    }

    _socket?.dispose(); // Clean up old socket if any
    
    _socket = io.io(
      '$_baseUrl/events',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token}) // Send fresh token
          .build(),
    );

    _socket?.connect();
    _socket?.onConnect((_) => print('✅ Admin Socket connected'));
    _socket?.onConnectError((err) => print('❌ Admin Socket Connect Error: $err'));
    _socket?.onDisconnect((_) => print('❌ Admin Socket disconnected'));
  }

  void on(String eventName, Function(dynamic) callback) =>
      _socket?.on(eventName, callback);

  void off(String eventName) => _socket?.off(eventName);

  void emit(String eventName, dynamic data) =>
      _socket?.emit(eventName, data);

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }
}

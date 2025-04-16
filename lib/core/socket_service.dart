// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  late IO.Socket _socket;
  final _storage = FlutterSecureStorage();

  SocketService._internal() {
    initSocket();
  }

  Future<void> initSocket() async {
    try {
      String token = await _storage.read(key: 'token') ?? '';
      log('[SOCKET] Initializing with token: $token');

      _socket = IO.io(
        'http://192.168.1.102:6000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({'Authorization': 'Bearer $token'})
            .build(),
      );

      _socket.connect();

      _socket.onConnect((_) {
        log('[SOCKET] ✅ Connected with ID: ${_socket.id}');
      });

      _socket.onDisconnect((_) {
        log('[SOCKET] ❌ Disconnected');
      });

      _socket.onConnectError((err) {
        log('[SOCKET] ⚠️ Connect Error: $err');
      });

      _socket.onError((err) {
        log('[SOCKET] ❗ Socket Error: $err');
      });

      // Log all socket events for debugging
      _socket.onAny((event, data) {
        log('[SOCKET] 🔄 Event: $event, Data: $data');
      });

    } catch (e) {
      log('[SOCKET] 🚨 Exception during init: $e');
    }
  }

  IO.Socket get socket => _socket;
}

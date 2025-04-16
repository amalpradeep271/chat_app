// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:chat_app/feature/chat/data/model/message_model.dart';
import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MessagesRemoteDatasource {
  final String baseUrl = "http://192.168.1.102:6000";
  final _storage = FlutterSecureStorage();

  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/messages/$conversationId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => MessageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch Conversations');
    }
  }
}

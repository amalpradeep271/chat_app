import 'dart:convert';

import 'package:chat_app/feature/auth/data/models/user_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  final String baseUrl = "http://localhost:6000/auth";

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    return UserModel.fromJson(jsonDecode(response.body));
  }

  Future<UserModel> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    return UserModel.fromJson(jsonDecode(response.body));
  }
}

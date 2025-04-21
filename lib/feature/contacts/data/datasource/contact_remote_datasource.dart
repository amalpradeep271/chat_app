// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:chat_app/core/appurls.dart';
import 'package:chat_app/feature/contacts/data/model/contacts_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ContactRemoteDatasource {
  final _storage = FlutterSecureStorage();

  Future<List<ContactsModel>> fetchContacts() async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(
      Uri.parse('${Appurls.baseUrl}/contacts'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ContactsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch Contacts');
    }
  }

  Future<void> addContact({required String email}) async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.post(
      Uri.parse('${Appurls.baseUrl}/contacts'),
      body: jsonEncode({'contactEmail': email}),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add contact');
    }
  }
}

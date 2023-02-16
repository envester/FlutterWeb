import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';

class AuthService {
  static final AuthService _instance = AuthService._privateConstructor();

  AuthService._privateConstructor();

  factory AuthService() {
    return _instance;
  }

  Future<bool> signUp(String fullName, String email, String password,
      List<String> roles) async {
    try {
      final user = User(
          fullName: fullName, email: email, password: password, roles: roles);
      const url = 'https://localhost:44323/api/Account/register';
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(user.toJson()),
        headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
      );

      if (response.statusCode != HttpStatus.accepted) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static const storage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    try {
      final user = User(email: email, password: password);
      const url = 'https://localhost:44323/api/Account/login';

      final response = await http.post(
        Uri.parse(url),
        body: json.encode(user),
        headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
      );

      if (response.statusCode != HttpStatus.accepted) {
        return false;
      }

      var responseJson = json.decode(response.body);
      await storage.write(key: "jwt", value: responseJson["access_token"]);
      return true;
    } catch (e) {
      return false;
    }
  }
}

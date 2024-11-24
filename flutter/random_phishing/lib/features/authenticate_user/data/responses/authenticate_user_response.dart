import 'package:flutter/foundation.dart';

class AuthenticateUserResponse {
  final String username;
  final String role;
  AuthenticateUserResponse({required this.username, required this.role});

  factory AuthenticateUserResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticateUserResponse(username: json["username"], role: json["role"]);
  }
}

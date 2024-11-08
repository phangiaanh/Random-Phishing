import 'package:flutter/foundation.dart';

class AuthenticateUserResponse {
  final String id;
  final String name;
  AuthenticateUserResponse({@required this.id, @required this.name});

  factory AuthenticateUserResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticateUserResponse(name: json["name"], id: json["id"]);
  }
}

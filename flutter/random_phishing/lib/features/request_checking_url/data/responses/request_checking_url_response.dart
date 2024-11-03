import 'package:flutter/foundation.dart';

class RequestCheckingUrlResponse {
  final String id;
  final String name;
  RequestCheckingUrlResponse({@required this.id, @required this.name});

  factory RequestCheckingUrlResponse.fromJson(Map<String, dynamic> json) {
    return RequestCheckingUrlResponse(name: json["name"], id: json["id"]);
  }
}

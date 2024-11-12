import 'package:flutter/foundation.dart';

class ListPhishingHistoryResponse {
  final String id;
  final String name;
  ListPhishingHistoryResponse({@required this.id, @required this.name});

  factory ListPhishingHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ListPhishingHistoryResponse(name: json["name"], id: json["id"]);
  }
}

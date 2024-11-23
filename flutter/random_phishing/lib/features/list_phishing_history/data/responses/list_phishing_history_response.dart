import 'dart:core';

import 'package:flutter/foundation.dart';

class ListPhishingHistoryResponse {
  final List<PhishingHistoryResponse> list;
  ListPhishingHistoryResponse({required this.list});

  // factory ListPhishingHistoryResponse.fromJson(Map<String, dynamic> json) {
  //   return ListPhishingHistoryResponse(name: json["name"], id: json["id"]);
  // }
}

class PhishingHistoryResponse {
  final String username;
  final String url;
  final bool isPhishing;
  final DateTime time;

  PhishingHistoryResponse(
      {required this.username,
      required this.url,
      required this.isPhishing,
      required this.time});
}

import 'package:flutter/foundation.dart';

class DetectPhishingUrlResponse {
  final String url;
  final bool isPhishing;
  final int detecTurn;
  final List<String> reasons;
  DetectPhishingUrlResponse(
      {required this.url,
      required this.isPhishing,
      required this.detecTurn,
      required this.reasons});

  // factory DetectPhishingUrlResponse.fromJson(Map<String, dynamic> json) {
  //   return DetectPhishingUrlResponse(name: json["name"], id: json["id"]);
  // }
}

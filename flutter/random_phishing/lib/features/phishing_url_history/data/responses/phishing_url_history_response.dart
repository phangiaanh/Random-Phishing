import 'package:flutter/foundation.dart';

class PhishingUrlHistoryResponse {
  final String id;
  final String name;
  PhishingUrlHistoryResponse({@required this.id, @required this.name});

  factory PhishingUrlHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PhishingUrlHistoryResponse(name: json["name"], id: json["id"]);
  }
}

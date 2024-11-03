import 'package:random_phishing/features/phishing_url_history/data/responses/phishing_url_history_response.dart';

abstract class PhishingUrlHistoryRemoteDataSource {
  Future<PhishingUrlHistoryResponse> fetchPhishingUrlHistory({String id});
}

class PhishingUrlHistoryRemoteDataSourceImpl implements PhishingUrlHistoryRemoteDataSource {
  @override
  Future<PhishingUrlHistoryResponse> fetchPhishingUrlHistory({String id}) async {
    return PhishingUrlHistoryResponse(id: "", name: "");
  }
}

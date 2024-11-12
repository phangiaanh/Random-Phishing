import 'package:random_phishing/features/list_phishing_history/data/responses/list_phishing_history_response.dart';

abstract class ListPhishingHistoryRemoteDataSource {
  Future<ListPhishingHistoryResponse> fetchListPhishingHistory({String id});
}

class ListPhishingHistoryRemoteDataSourceImpl implements ListPhishingHistoryRemoteDataSource {
  @override
  Future<ListPhishingHistoryResponse> fetchListPhishingHistory({String id}) async {
    return ListPhishingHistoryResponse(id: "", name: "");
  }
}

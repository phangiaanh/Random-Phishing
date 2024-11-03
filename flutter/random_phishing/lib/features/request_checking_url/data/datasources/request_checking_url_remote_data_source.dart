import 'package:random_phishing/features/request_checking_url/data/responses/request_checking_url_response.dart';

abstract class RequestCheckingUrlRemoteDataSource {
  Future<RequestCheckingUrlResponse> fetchRequestCheckingUrl({String id});
}

class RequestCheckingUrlRemoteDataSourceImpl implements RequestCheckingUrlRemoteDataSource {
  @override
  Future<RequestCheckingUrlResponse> fetchRequestCheckingUrl({String id}) async {
    return RequestCheckingUrlResponse(id: "", name: "");
  }
}

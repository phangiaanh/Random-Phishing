import 'package:random_phishing/features/detect_phishing_url/data/responses/detect_phishing_url_response.dart';

abstract class DetectPhishingUrlRemoteDataSource {
  Future<DetectPhishingUrlResponse> fetchDetectPhishingUrl({String url});
}

class DetectPhishingUrlRemoteDataSourceImpl
    implements DetectPhishingUrlRemoteDataSource {
  @override
  Future<DetectPhishingUrlResponse> fetchDetectPhishingUrl({String id}) async {
    return DetectPhishingUrlResponse(id: "", name: "");
  }
}

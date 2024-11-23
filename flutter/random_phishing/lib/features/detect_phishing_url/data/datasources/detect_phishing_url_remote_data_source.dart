import 'package:dartz/dartz.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/utils/const/const.dart';
import 'package:random_phishing/features/detect_phishing_url/data/responses/detect_phishing_url_response.dart';
import 'package:random_phishing/features/list_phishing_history/data/datasources/list_phishing_history_remote_data_source.dart';

abstract class DetectPhishingUrlRemoteDataSource {
  Future<Either<Failure, DetectPhishingUrlResponse>> fetchDetectPhishingUrl(
      {required String url, required String role, required String user});
}

class DetectPhishingUrlRemoteDataSourceImpl
    implements DetectPhishingUrlRemoteDataSource {
  static int GuestCounter = 0;

  @override
  Future<Either<Failure, DetectPhishingUrlResponse>> fetchDetectPhishingUrl(
      {required String url, required String role, required String user}) async {
    if (role == DefinedRole.RoleGuest) {
      GuestCounter++;
    }

    if (url.startsWith("https://")) {
      ListPhishingHistoryRemoteDataSourceImpl.setLogHistory(
          user, url, false, DateTime.now());
      return Right(DetectPhishingUrlResponse(
          url: url,
          isPhishing: false,
          detecTurn: (role == DefinedRole.RoleGuest) ? GuestCounter : -1,
          reasons: [DefinedReasons.httpsReason]));
    }
    ListPhishingHistoryRemoteDataSourceImpl.setLogHistory(
        user, url, true, DateTime.now());
    return Right(DetectPhishingUrlResponse(
        url: url,
        isPhishing: true,
        detecTurn: (role == DefinedRole.RoleGuest) ? GuestCounter : -1,
        reasons: [DefinedReasons.protocolReason]));
  }
}

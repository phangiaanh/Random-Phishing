import 'package:dartz/dartz.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/utils/const/const.dart';
import 'package:random_phishing/features/list_phishing_history/data/responses/list_phishing_history_response.dart';

abstract class ListPhishingHistoryRemoteDataSource {
  Future<Either<Failure, ListPhishingHistoryResponse>> fetchListPhishingHistory(
      {required String username});
}

class ListPhishingHistoryRemoteDataSourceImpl
    implements ListPhishingHistoryRemoteDataSource {
  static Map<String, List<PhishingHistoryResponse>> mapPhishingHistoryByUser =
      Map();

  static setLogHistory(
      String user, String url, bool isPhishing, DateTime time) {
    if (!mapPhishingHistoryByUser.containsKey(user)) {
      mapPhishingHistoryByUser[user] = [];
    }
    mapPhishingHistoryByUser[user]?.add(PhishingHistoryResponse(
        username: user, url: url, isPhishing: isPhishing, time: time));
  }

  @override
  Future<Either<Failure, ListPhishingHistoryResponse>> fetchListPhishingHistory(
      {required String username}) async {
    if (DataSourceUser.user[username]["role"] != DefinedRole.RoleAdmin)
      return Right(ListPhishingHistoryResponse(
          list: mapPhishingHistoryByUser[username] ??
              <PhishingHistoryResponse>[]));

    List<PhishingHistoryResponse> res = [];
    for (var item in mapPhishingHistoryByUser.values) {
      res = res + item;
    }
    return Right(ListPhishingHistoryResponse(list: res));
  }
}

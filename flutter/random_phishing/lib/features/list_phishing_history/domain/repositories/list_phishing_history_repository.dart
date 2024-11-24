import 'package:dartz/dartz.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/features/list_phishing_history/domain/entities/list_phishing_history_entity.dart';
import 'package:random_phishing/features/list_phishing_history/domain/usecases/fetch_list_phishing_history_usecase.dart';

abstract class ListPhishingHistoryRepository {
  Future<Either<Failure, ListPhishingHistoryEntity>> fetchListPhishingHistory(
      {required FetchListPhishingHistoryParam params});
}

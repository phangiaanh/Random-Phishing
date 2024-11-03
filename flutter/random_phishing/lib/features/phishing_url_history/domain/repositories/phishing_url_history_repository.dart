import 'package:dartz/dartz.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/features/phishing_url_history/domain/entities/phishing_url_history_entity.dart';
import 'package:random_phishing/features/phishing_url_history/domain/usecases/fetch_phishing_url_history_usecase.dart';

abstract class PhishingUrlHistoryRepository {
  Future<Either<Failure, PhishingUrlHistoryEntity>> fetchPhishingUrlHistory({FetchPhishingUrlHistoryParam params});
}

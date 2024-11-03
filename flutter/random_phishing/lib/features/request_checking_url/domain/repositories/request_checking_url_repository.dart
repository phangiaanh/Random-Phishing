import 'package:dartz/dartz.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/features/request_checking_url/domain/entities/request_checking_url_entity.dart';
import 'package:random_phishing/features/request_checking_url/domain/usecases/fetch_request_checking_url_usecase.dart';

abstract class RequestCheckingUrlRepository {
  Future<Either<Failure, RequestCheckingUrlEntity>> fetchRequestCheckingUrl({FetchRequestCheckingUrlParam params});
}

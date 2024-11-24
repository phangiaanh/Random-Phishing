import 'package:dartz/dartz.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/features/detect_phishing_url/domain/entities/detect_phishing_url_entity.dart';
import 'package:random_phishing/features/detect_phishing_url/domain/usecases/fetch_detect_phishing_url_usecase.dart';

abstract class DetectPhishingUrlRepository {
  Future<Either<Failure, DetectPhishingUrlEntity>> fetchDetectPhishingUrl(
      {required FetchDetectPhishingUrlParam params});
}

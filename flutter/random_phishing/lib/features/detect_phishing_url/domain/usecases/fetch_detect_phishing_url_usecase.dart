import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/usecases/usecase.dart';
import 'package:random_phishing/features/detect_phishing_url/domain/entities/detect_phishing_url_entity.dart';
import 'package:random_phishing/features/detect_phishing_url/domain/repositories/detect_phishing_url_repository.dart';

class FetchDetectPhishingUrlUseCase
    extends UseCase<DetectPhishingUrlEntity, FetchDetectPhishingUrlParam> {
  final DetectPhishingUrlRepository repository;

  FetchDetectPhishingUrlUseCase(this.repository);

  @override
  Future<Either<Failure, DetectPhishingUrlEntity>> call(
      FetchDetectPhishingUrlParam params) async {
    return await repository.fetchDetectPhishingUrl(params: params);
  }
}

class FetchDetectPhishingUrlParam {
  String url;
  FetchDetectPhishingUrlParam({required this.url});
}

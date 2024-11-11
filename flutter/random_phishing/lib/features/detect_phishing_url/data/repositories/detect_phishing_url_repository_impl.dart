import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/error/exceptions.dart';
import 'package:random_phishing/features/detect_phishing_url/data/datasources/detect_phishing_url_remote_data_source.dart';
import 'package:random_phishing/features/detect_phishing_url/data/responses/detect_phishing_url_response.dart';
import 'package:random_phishing/features/detect_phishing_url/domain/entities/detect_phishing_url_entity.dart';
import 'package:random_phishing/features/detect_phishing_url/domain/repositories/detect_phishing_url_repository.dart';
import 'package:random_phishing/features/detect_phishing_url/domain/usecases/fetch_detect_phishing_url_usecase.dart';

class DetectPhishingUrlRepositoryImpl implements DetectPhishingUrlRepository {
  DetectPhishingUrlRemoteDataSource detectPhishingUrlRemoteDataSource;

  DetectPhishingUrlRepositoryImpl(
      {required this.detectPhishingUrlRemoteDataSource});

  @override
  Future<Either<Failure, DetectPhishingUrlEntity>> fetchDetectPhishingUrl(
      {required FetchDetectPhishingUrlParam params}) async {
    try {
      var _response = await detectPhishingUrlRemoteDataSource
          .fetchDetectPhishingUrl(url: params.url);
      return Right(_mapPDResponseToEntity(response: _response));
    } on ServerException {
      return Left(ServerFailure(""));
    } catch (e) {
      return Left(ServerFailure(""));
    }
  }

  DetectPhishingUrlEntity _mapPDResponseToEntity(
      {required DetectPhishingUrlResponse response}) {
    return DetectPhishingUrlEntity(
        url: response.url,
        isPhishing: response.isPhishing,
        detectTurn: response.detecTurn,
        reasons: response.reasons);
  }
}

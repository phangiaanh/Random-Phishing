import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/error/exceptions.dart';
import 'package:random_phishing/features/request_checking_url/data/datasources/request_checking_url_remote_data_source.dart';
import 'package:random_phishing/features/request_checking_url/data/responses/request_checking_url_response.dart';
import 'package:random_phishing/features/request_checking_url/domain/entities/request_checking_url_entity.dart';
import 'package:random_phishing/features/request_checking_url/domain/repositories/request_checking_url_repository.dart';
import 'package:random_phishing/features/request_checking_url/domain/usecases/fetch_request_checking_url_usecase.dart';

class RequestCheckingUrlRepositoryImpl implements RequestCheckingUrlRepository {
  RequestCheckingUrlRemoteDataSource requestCheckingUrlRemoteDataSource;

  RequestCheckingUrlRepositoryImpl({@required this.requestCheckingUrlRemoteDataSource});

  @override
  Future<Either<Failure, RequestCheckingUrlEntity>> fetchRequestCheckingUrl({@required FetchRequestCheckingUrlParam params}) async {
    try {
      var _response = await requestCheckingUrlRemoteDataSource.fetchRequestCheckingUrl(id: params.id);
      return Right(_mapPDResponseToEntity(response: _response));
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  RequestCheckingUrlEntity _mapPDResponseToEntity({@required RequestCheckingUrlResponse response}) {
    return RequestCheckingUrlEntity(
      id: response.id,
      name: response.name,
    );
  }
}

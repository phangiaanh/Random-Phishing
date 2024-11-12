import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/error/exceptions.dart';
import 'package:random_phishing/features/list_phishing_history/data/datasources/list_phishing_history_remote_data_source.dart';
import 'package:random_phishing/features/list_phishing_history/data/responses/list_phishing_history_response.dart';
import 'package:random_phishing/features/list_phishing_history/domain/entities/list_phishing_history_entity.dart';
import 'package:random_phishing/features/list_phishing_history/domain/repositories/list_phishing_history_repository.dart';
import 'package:random_phishing/features/list_phishing_history/domain/usecases/fetch_list_phishing_history_usecase.dart';

class ListPhishingHistoryRepositoryImpl implements ListPhishingHistoryRepository {
  ListPhishingHistoryRemoteDataSource listPhishingHistoryRemoteDataSource;

  ListPhishingHistoryRepositoryImpl({@required this.listPhishingHistoryRemoteDataSource});

  @override
  Future<Either<Failure, ListPhishingHistoryEntity>> fetchListPhishingHistory({@required FetchListPhishingHistoryParam params}) async {
    try {
      var _response = await listPhishingHistoryRemoteDataSource.fetchListPhishingHistory(id: params.id);
      return Right(_mapPDResponseToEntity(response: _response));
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  ListPhishingHistoryEntity _mapPDResponseToEntity({@required ListPhishingHistoryResponse response}) {
    return ListPhishingHistoryEntity(
      id: response.id,
      name: response.name,
    );
  }
}

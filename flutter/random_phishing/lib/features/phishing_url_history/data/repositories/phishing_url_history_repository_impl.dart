import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/error/exceptions.dart';
import 'package:random_phishing/features/phishing_url_history/data/datasources/phishing_url_history_remote_data_source.dart';
import 'package:random_phishing/features/phishing_url_history/data/responses/phishing_url_history_response.dart';
import 'package:random_phishing/features/phishing_url_history/domain/entities/phishing_url_history_entity.dart';
import 'package:random_phishing/features/phishing_url_history/domain/repositories/phishing_url_history_repository.dart';
import 'package:random_phishing/features/phishing_url_history/domain/usecases/fetch_phishing_url_history_usecase.dart';

class PhishingUrlHistoryRepositoryImpl implements PhishingUrlHistoryRepository {
  PhishingUrlHistoryRemoteDataSource phishingUrlHistoryRemoteDataSource;

  PhishingUrlHistoryRepositoryImpl({@required this.phishingUrlHistoryRemoteDataSource});

  @override
  Future<Either<Failure, PhishingUrlHistoryEntity>> fetchPhishingUrlHistory({@required FetchPhishingUrlHistoryParam params}) async {
    try {
      var _response = await phishingUrlHistoryRemoteDataSource.fetchPhishingUrlHistory(id: params.id);
      return Right(_mapPDResponseToEntity(response: _response));
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  PhishingUrlHistoryEntity _mapPDResponseToEntity({@required PhishingUrlHistoryResponse response}) {
    return PhishingUrlHistoryEntity(
      id: response.id,
      name: response.name,
    );
  }
}

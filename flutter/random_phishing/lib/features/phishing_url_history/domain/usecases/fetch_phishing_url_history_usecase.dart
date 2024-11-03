import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/usecases/usecase.dart';
import 'package:random_phishing/features/phishing_url_history/domain/entities/phishing_url_history_entity.dart';
import 'package:random_phishing/features/phishing_url_history/domain/repositories/phishing_url_history_repository.dart';

class FetchPhishingUrlHistoryUseCase extends UseCase<PhishingUrlHistoryEntity, FetchPhishingUrlHistoryParam> {
  final PhishingUrlHistoryRepository repository;

  FetchPhishingUrlHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, PhishingUrlHistoryEntity>> call(FetchPhishingUrlHistoryParam params) async {
    return await repository.fetchPhishingUrlHistory(params: params);
  }
}

class FetchPhishingUrlHistoryParam {
  String id;
  FetchPhishingUrlHistoryParam({@required this.id});
}

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/usecases/usecase.dart';
import 'package:random_phishing/features/list_phishing_history/domain/entities/list_phishing_history_entity.dart';
import 'package:random_phishing/features/list_phishing_history/domain/repositories/list_phishing_history_repository.dart';

class FetchListPhishingHistoryUseCase
    extends UseCase<ListPhishingHistoryEntity, FetchListPhishingHistoryParam> {
  final ListPhishingHistoryRepository repository;

  FetchListPhishingHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, ListPhishingHistoryEntity>> call(
      FetchListPhishingHistoryParam params) async {
    return await repository.fetchListPhishingHistory(params: params);
  }
}

class FetchListPhishingHistoryParam {
  String username;
  FetchListPhishingHistoryParam({required this.username});
}

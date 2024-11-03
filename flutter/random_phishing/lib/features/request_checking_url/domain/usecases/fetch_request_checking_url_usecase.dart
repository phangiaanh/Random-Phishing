import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/usecases/usecase.dart';
import 'package:random_phishing/features/request_checking_url/domain/entities/request_checking_url_entity.dart';
import 'package:random_phishing/features/request_checking_url/domain/repositories/request_checking_url_repository.dart';

class FetchRequestCheckingUrlUseCase extends UseCase<RequestCheckingUrlEntity, FetchRequestCheckingUrlParam> {
  final RequestCheckingUrlRepository repository;

  FetchRequestCheckingUrlUseCase(this.repository);

  @override
  Future<Either<Failure, RequestCheckingUrlEntity>> call(FetchRequestCheckingUrlParam params) async {
    return await repository.fetchRequestCheckingUrl(params: params);
  }
}

class FetchRequestCheckingUrlParam {
  String id;
  FetchRequestCheckingUrlParam({@required this.id});
}

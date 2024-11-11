import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/usecases/usecase.dart';
import 'package:random_phishing/features/authenticate_user/domain/entities/authenticate_user_entity.dart';
import 'package:random_phishing/features/authenticate_user/domain/repositories/authenticate_user_repository.dart';

class FetchAuthenticateUserUseCase
    extends UseCase<AuthenticateUserEntity, FetchAuthenticateUserParam> {
  final AuthenticateUserRepository repository;

  FetchAuthenticateUserUseCase(this.repository);

  @override
  Future<Either<Failure, AuthenticateUserEntity>> call(
      FetchAuthenticateUserParam params) async {
    return await repository.fetchAuthenticateUser(params: params);
  }
}

class FetchAuthenticateUserParam {
  String username;
  String password;
  bool isLoginAsGuest;
  FetchAuthenticateUserParam(
      {required this.username,
      required this.password,
      required this.isLoginAsGuest});
}

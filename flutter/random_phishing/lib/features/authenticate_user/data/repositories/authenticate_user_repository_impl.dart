import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/error/exceptions.dart';
import 'package:random_phishing/features/authenticate_user/data/datasources/authenticate_user_remote_data_source.dart';
import 'package:random_phishing/features/authenticate_user/data/responses/authenticate_user_response.dart';
import 'package:random_phishing/features/authenticate_user/domain/entities/authenticate_user_entity.dart';
import 'package:random_phishing/features/authenticate_user/domain/repositories/authenticate_user_repository.dart';
import 'package:random_phishing/features/authenticate_user/domain/usecases/fetch_authenticate_user_usecase.dart';

class AuthenticateUserRepositoryImpl implements AuthenticateUserRepository {
  AuthenticateUserRemoteDataSource authenticateUserRemoteDataSource;

  AuthenticateUserRepositoryImpl(
      {required this.authenticateUserRemoteDataSource});

  @override
  Future<Either<Failure, AuthenticateUserEntity>> fetchAuthenticateUser(
      {required FetchAuthenticateUserParam params}) async {
    try {
      var _response =
          await authenticateUserRemoteDataSource.fetchAuthenticateUser(
              username: params.username,
              password: params.password,
              isGuest: params.isLoginAsGuest);
      return _response.fold((failure) => Left(ServerFailure("")),
          (data) => Right(_mapPDResponseToEntity(response: data)));
    } on ServerException {
      return Left(ServerFailure(""));
    } catch (e) {
      return Left(ServerFailure(""));
    }
  }

  AuthenticateUserEntity _mapPDResponseToEntity(
      {required AuthenticateUserResponse response}) {
    return AuthenticateUserEntity(
      username: response.username,
      role: response.role,
      password: "",
    );
  }
}

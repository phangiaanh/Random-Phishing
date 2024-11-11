import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/core/utils/const/const.dart';
import 'package:random_phishing/features/authenticate_user/data/responses/authenticate_user_response.dart';

abstract class AuthenticateUserRemoteDataSource {
  Future<Either<Failure, AuthenticateUserResponse>> fetchAuthenticateUser(
      {required String username,
      required String password,
      required bool isGuest});
}

class AuthenticateUserRemoteDataSourceImpl
    implements AuthenticateUserRemoteDataSource {
  @override
  Future<Either<Failure, AuthenticateUserResponse>> fetchAuthenticateUser(
      {required String username,
      required String password,
      required bool isGuest}) async {
    if (isGuest) {
      return Right(AuthenticateUserResponse(username: "guest", role: "guest"));
    } else {
      if (DataSourceUser.user.containsKey(username)) {
        if (password == DataSourceUser.user[username]['pass']) {
          return Right(AuthenticateUserResponse(
              username: username, role: DataSourceUser.user[username]['role']));
        }
      } else {
        return Left(ServerFailure("nonexist.user"));
      }
    }

    return Left(ServerFailure("nonexist.user"));
  }
}

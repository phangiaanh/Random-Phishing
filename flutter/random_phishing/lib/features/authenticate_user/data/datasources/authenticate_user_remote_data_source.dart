import 'dart:ffi';

import 'package:random_phishing/features/authenticate_user/data/responses/authenticate_user_response.dart';

abstract class AuthenticateUserRemoteDataSource {
  Future<AuthenticateUserResponse> fetchAuthenticateUser({required String username,required String password,required Bool isGuest});
}

class AuthenticateUserRemoteDataSourceImpl implements AuthenticateUserRemoteDataSource {
  @override
  Future<AuthenticateUserResponse> fetchAuthenticateUser({required String username,required String password,required Bool isGuest}) async {
    return AuthenticateUserResponse(username: "", role: "");
  }
}

import 'package:random_phishing/features/authenticate_user/data/responses/authenticate_user_response.dart';

abstract class AuthenticateUserRemoteDataSource {
  Future<AuthenticateUserResponse> fetchAuthenticateUser({String id});
}

class AuthenticateUserRemoteDataSourceImpl implements AuthenticateUserRemoteDataSource {
  @override
  Future<AuthenticateUserResponse> fetchAuthenticateUser({String id}) async {
    return AuthenticateUserResponse(id: "", name: "");
  }
}

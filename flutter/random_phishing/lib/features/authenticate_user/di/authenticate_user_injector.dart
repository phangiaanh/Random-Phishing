import 'package:random_phishing/features/authenticate_user/data/datasources/authenticate_user_remote_data_source.dart';
import 'package:random_phishing/features/authenticate_user/data/repositories/authenticate_user_repository_impl.dart';
import 'package:random_phishing/features/authenticate_user/domain/usecases/fetch_authenticate_user_usecase.dart';

final _injector = _Injector();
final fetchAuthenticateUserUseCase = _injector.fetchAuthenticateUserUseCase;

class _Injector {
  _Injector._internal();
  static final _singleton = _Injector._internal();
  factory _Injector() => _singleton;

  AuthenticateUserRemoteDataSourceImpl get authenticateUserRemoteDataSourceImpl => AuthenticateUserRemoteDataSourceImpl();
  AuthenticateUserRepositoryImpl get authenticateUserRepositoryImpl => AuthenticateUserRepositoryImpl(authenticateUserRemoteDataSource: authenticateUserRemoteDataSourceImpl);
  FetchAuthenticateUserUseCase get fetchAuthenticateUserUseCase => FetchAuthenticateUserUseCase(authenticateUserRepositoryImpl);
}

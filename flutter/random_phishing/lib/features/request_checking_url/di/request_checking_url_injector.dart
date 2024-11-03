import 'package:random_phishing/features/request_checking_url/data/datasources/request_checking_url_remote_data_source.dart';
import 'package:random_phishing/features/request_checking_url/data/repositories/request_checking_url_repository_impl.dart';
import 'package:random_phishing/features/request_checking_url/domain/usecases/fetch_request_checking_url_usecase.dart';

final _injector = _Injector();
final fetchRequestCheckingUrlUseCase = _injector.fetchRequestCheckingUrlUseCase;

class _Injector {
  _Injector._internal();
  static final _singleton = _Injector._internal();
  factory _Injector() => _singleton;

  RequestCheckingUrlRemoteDataSourceImpl get requestCheckingUrlRemoteDataSourceImpl => RequestCheckingUrlRemoteDataSourceImpl();
  RequestCheckingUrlRepositoryImpl get requestCheckingUrlRepositoryImpl => RequestCheckingUrlRepositoryImpl(requestCheckingUrlRemoteDataSource: requestCheckingUrlRemoteDataSourceImpl);
  FetchRequestCheckingUrlUseCase get fetchRequestCheckingUrlUseCase => FetchRequestCheckingUrlUseCase(requestCheckingUrlRepositoryImpl);
}

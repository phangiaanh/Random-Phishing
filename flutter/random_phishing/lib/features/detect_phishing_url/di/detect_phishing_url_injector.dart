import 'package:random_phishing/features/detect_phishing_url/data/datasources/detect_phishing_url_remote_data_source.dart';
import 'package:random_phishing/features/detect_phishing_url/data/repositories/detect_phishing_url_repository_impl.dart';
import 'package:random_phishing/features/detect_phishing_url/domain/usecases/fetch_detect_phishing_url_usecase.dart';

final _injector = _Injector();
final fetchDetectPhishingUrlUseCase = _injector.fetchDetectPhishingUrlUseCase;

class _Injector {
  _Injector._internal();
  static final _singleton = _Injector._internal();
  factory _Injector() => _singleton;

  DetectPhishingUrlRemoteDataSourceImpl get detectPhishingUrlRemoteDataSourceImpl => DetectPhishingUrlRemoteDataSourceImpl();
  DetectPhishingUrlRepositoryImpl get detectPhishingUrlRepositoryImpl => DetectPhishingUrlRepositoryImpl(detectPhishingUrlRemoteDataSource: detectPhishingUrlRemoteDataSourceImpl);
  FetchDetectPhishingUrlUseCase get fetchDetectPhishingUrlUseCase => FetchDetectPhishingUrlUseCase(detectPhishingUrlRepositoryImpl);
}

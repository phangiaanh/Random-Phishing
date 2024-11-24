import 'package:random_phishing/features/list_phishing_history/data/datasources/list_phishing_history_remote_data_source.dart';
import 'package:random_phishing/features/list_phishing_history/data/repositories/list_phishing_history_repository_impl.dart';
import 'package:random_phishing/features/list_phishing_history/domain/usecases/fetch_list_phishing_history_usecase.dart';

final _injector = _Injector();
final fetchListPhishingHistoryUseCase = _injector.fetchListPhishingHistoryUseCase;

class _Injector {
  _Injector._internal();
  static final _singleton = _Injector._internal();
  factory _Injector() => _singleton;

  ListPhishingHistoryRemoteDataSourceImpl get listPhishingHistoryRemoteDataSourceImpl => ListPhishingHistoryRemoteDataSourceImpl();
  ListPhishingHistoryRepositoryImpl get listPhishingHistoryRepositoryImpl => ListPhishingHistoryRepositoryImpl(listPhishingHistoryRemoteDataSource: listPhishingHistoryRemoteDataSourceImpl);
  FetchListPhishingHistoryUseCase get fetchListPhishingHistoryUseCase => FetchListPhishingHistoryUseCase(listPhishingHistoryRepositoryImpl);
}

import 'package:random_phishing/features/phishing_url_history/data/datasources/phishing_url_history_remote_data_source.dart';
import 'package:random_phishing/features/phishing_url_history/data/repositories/phishing_url_history_repository_impl.dart';
import 'package:random_phishing/features/phishing_url_history/domain/usecases/fetch_phishing_url_history_usecase.dart';

final _injector = _Injector();
final fetchPhishingUrlHistoryUseCase = _injector.fetchPhishingUrlHistoryUseCase;

class _Injector {
  _Injector._internal();
  static final _singleton = _Injector._internal();
  factory _Injector() => _singleton;

  PhishingUrlHistoryRemoteDataSourceImpl get phishingUrlHistoryRemoteDataSourceImpl => PhishingUrlHistoryRemoteDataSourceImpl();
  PhishingUrlHistoryRepositoryImpl get phishingUrlHistoryRepositoryImpl => PhishingUrlHistoryRepositoryImpl(phishingUrlHistoryRemoteDataSource: phishingUrlHistoryRemoteDataSourceImpl);
  FetchPhishingUrlHistoryUseCase get fetchPhishingUrlHistoryUseCase => FetchPhishingUrlHistoryUseCase(phishingUrlHistoryRepositoryImpl);
}

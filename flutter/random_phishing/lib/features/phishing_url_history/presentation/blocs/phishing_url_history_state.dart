part of 'phishing_url_history_bloc.dart';

enum PhishingUrlHistoryStateStatus {
  init,
  showLoading,
  hideLoading,
  loadedSuccess,
  loadedFailed,
}

class PhishingUrlHistoryState extends Equatable {
  final PhishingUrlHistoryStateStatus status;
  final PhishingUrlHistoryEntity detail;
  final String errorMessage;

  PhishingUrlHistoryState({this.status, this.detail, this.errorMessage});

  PhishingUrlHistoryState copyWith({PhishingUrlHistoryStateStatus status, PhishingUrlHistoryEntity detail, String errorMessage}) =>
      PhishingUrlHistoryState(
       status: status ?? this.status,
       detail: detail ?? this.detail,
       errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object> get props => [status ?? '', detail ?? '', errorMessage ?? ''];
}

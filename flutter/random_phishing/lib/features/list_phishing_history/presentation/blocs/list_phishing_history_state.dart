part of 'list_phishing_history_bloc.dart';

enum ListPhishingHistoryStateStatus {
  init,
  showLoading,
  hideLoading,
  loadedSuccess,
  loadedFailed,
}

class ListPhishingHistoryState extends Equatable {
  final ListPhishingHistoryStateStatus status;
  final ListPhishingHistoryEntity detail;
  final String errorMessage;

  ListPhishingHistoryState({this.status, this.detail, this.errorMessage});

  ListPhishingHistoryState copyWith({ListPhishingHistoryStateStatus status, ListPhishingHistoryEntity detail, String errorMessage}) =>
      ListPhishingHistoryState(
       status: status ?? this.status,
       detail: detail ?? this.detail,
       errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object> get props => [status ?? '', detail ?? '', errorMessage ?? ''];
}

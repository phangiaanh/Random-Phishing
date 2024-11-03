part of 'request_checking_url_bloc.dart';

enum RequestCheckingUrlStateStatus {
  init,
  showLoading,
  hideLoading,
  loadedSuccess,
  loadedFailed,
}

class RequestCheckingUrlState extends Equatable {
  final RequestCheckingUrlStateStatus? status;
  final RequestCheckingUrlEntity? detail;
  final String? errorMessage;

  RequestCheckingUrlState({this.status, this.detail, this.errorMessage});

  RequestCheckingUrlState copyWith({RequestCheckingUrlStateStatus? status, RequestCheckingUrlEntity? detail, String? errorMessage}) =>
      RequestCheckingUrlState(
       status: status ?? this.status,
       detail: detail ?? this.detail,
       errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object> get props => [status ?? '', detail ?? '', errorMessage ?? ''];
}

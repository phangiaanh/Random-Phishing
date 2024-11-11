part of 'detect_phishing_url_bloc.dart';

enum DetectPhishingUrlStateStatus {
  init,
  showLoading,
  hideLoading,
  loadedSuccess,
  loadedFailed,
}

class DetectPhishingUrlState extends Equatable {
  final DetectPhishingUrlStateStatus status;
  final int detectTurn;
  final String errorMessage;

  DetectPhishingUrlState(
      {required this.status,
      required this.detectTurn,
      required this.errorMessage});

  DetectPhishingUrlState copyWith(
          {DetectPhishingUrlStateStatus status =
              DetectPhishingUrlStateStatus.init,
          int detectTurn = 0,
          String errorMessage = ""}) =>
      DetectPhishingUrlState(
          status: status ?? this.status,
          detectTurn: detectTurn ?? this.detectTurn,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object> get props =>
      [status ?? '', detectTurn ?? '', errorMessage ?? ''];
}

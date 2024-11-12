part of 'detect_phishing_url_bloc.dart';

abstract class DetectPhishingUrlEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventFetchDetectPhishingUrl extends DetectPhishingUrlEvent {
  final String url;
  final String role;

  EventFetchDetectPhishingUrl({required this.url, required this.role});

  @override
  List<Object> get props => [url];
}

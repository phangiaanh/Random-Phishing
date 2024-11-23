part of 'detect_phishing_url_bloc.dart';

abstract class DetectPhishingUrlEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventFetchDetectPhishingUrl extends DetectPhishingUrlEvent {
  final String url;
  final String role;
  final String user;

  EventFetchDetectPhishingUrl(
      {required this.url, required this.role, required this.user});

  @override
  List<Object> get props => [url];
}

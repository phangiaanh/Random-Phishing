part of 'detect_phishing_url_bloc.dart';

abstract class DetectPhishingUrlEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventFetchDetectPhishingUrl extends DetectPhishingUrlEvent {
  final String url;

  EventFetchDetectPhishingUrl({required this.url});

  @override
  List<Object> get props => [url];
}

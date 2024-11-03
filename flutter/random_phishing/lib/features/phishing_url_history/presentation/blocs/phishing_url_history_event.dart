part of 'phishing_url_history_bloc.dart';

abstract class PhishingUrlHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventFetchPhishingUrlHistory extends PhishingUrlHistoryEvent {
  final String id;

  EventFetchPhishingUrlHistory({@required this.id});

  @override
  List<Object> get props => [id];
}
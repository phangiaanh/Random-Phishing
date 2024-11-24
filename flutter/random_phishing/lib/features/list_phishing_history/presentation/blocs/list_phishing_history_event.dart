part of 'list_phishing_history_bloc.dart';

abstract class ListPhishingHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventFetchListPhishingHistory extends ListPhishingHistoryEvent {
  final String username;

  EventFetchListPhishingHistory({required this.username});

  @override
  List<Object> get props => [username];
}

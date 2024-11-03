part of 'request_checking_url_bloc.dart';

abstract class RequestCheckingUrlEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventFetchRequestCheckingUrl extends RequestCheckingUrlEvent {
  final String id;

  EventFetchRequestCheckingUrl({@required this.id});

  @override
  List<Object> get props => [id];
}
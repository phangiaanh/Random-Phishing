part of 'authenticate_user_bloc.dart';

abstract class AuthenticateUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventFetchAuthenticateUser extends AuthenticateUserEvent {
  final String id;

  EventFetchAuthenticateUser({required this.id});

  @override
  List<Object> get props => [id];
}

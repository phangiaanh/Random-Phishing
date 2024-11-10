part of 'authenticate_user_bloc.dart';

abstract class AuthenticateUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventFetchAuthenticateUser extends AuthenticateUserEvent {
  final String username;
  final String password;
  final Bool loginasGuest;

  EventFetchAuthenticateUser({required this.username,required this.password,required this.loginasGuest});

  @override
  List<Object> get props => [username];
}

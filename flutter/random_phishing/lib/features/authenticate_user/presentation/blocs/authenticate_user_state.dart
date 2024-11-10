part of 'authenticate_user_bloc.dart';

enum AuthenticateUserStateStatus {
  init,
  showLoading,
  hideLoading,
  loadedSuccess,
  loadedFailed,
}

enum AuthenticateUserRole {
  guest,
  user,
  admin,
}

class AuthenticateUserState extends Equatable {
  final AuthenticateUserStateStatus status;
  final AuthenticateUserRole role;
  final String errorMessage;

  static Map mapAuthenticateCodeToRole = {
    "guest": AuthenticateUserRole.guest,
    "user": AuthenticateUserRole.user,
    "admin": AuthenticateUserRole.admin,
  };

  AuthenticateUserState({required this.status,required this.role,required this.errorMessage});

  AuthenticateUserState copyWith(
          {AuthenticateUserStateStatus status =
              AuthenticateUserStateStatus.init,
          AuthenticateUserRole role = AuthenticateUserRole.guest,
          String errorMessage = ""}) =>
      AuthenticateUserState(
          status: status ?? this.status,
          role: role ?? this.role,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object> get props => [status ?? AuthenticateUserStateStatus.init, role ?? AuthenticateUserRole.guest, errorMessage ?? ""];
}

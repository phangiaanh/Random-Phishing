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
  final String user;
  final String errorMessage;

  static Map mapAuthenticateCodeToRole = {
    DefinedRole.RoleGuest: AuthenticateUserRole.guest,
    DefinedRole.RoleUser: AuthenticateUserRole.user,
    DefinedRole.RoleAdmin: AuthenticateUserRole.admin,
  };

  static Map mapAuthenticateRoleToCode = {
    AuthenticateUserRole.guest: DefinedRole.RoleGuest,
    AuthenticateUserRole.user: DefinedRole.RoleUser,
    AuthenticateUserRole.admin: DefinedRole.RoleAdmin,
  };

  AuthenticateUserState(
      {required this.status,
      required this.role,
      required this.errorMessage,
      required this.user});

  AuthenticateUserState copyWith(
          {AuthenticateUserStateStatus status =
              AuthenticateUserStateStatus.init,
          AuthenticateUserRole role = AuthenticateUserRole.guest,
          String user = "anonymous",
          String errorMessage = ""}) =>
      AuthenticateUserState(
          status: status ?? this.status,
          role: role ?? this.role,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object> get props => [
        status ?? AuthenticateUserStateStatus.init,
        role ?? AuthenticateUserRole.guest,
        errorMessage ?? "",
        user ?? "anonymous"
      ];
}

part of 'authenticate_user_bloc.dart';

enum AuthenticateUserStateStatus {
  init,
  showLoading,
  hideLoading,
  loadedSuccess,
  loadedFailed,
}

class AuthenticateUserState extends Equatable {
  final AuthenticateUserStateStatus status;
  final AuthenticateUserEntity detail;
  final String errorMessage;

  AuthenticateUserState({required this.status, this.detail, this.errorMessage});

  AuthenticateUserState copyWith(
          {AuthenticateUserStateStatus status =
              AuthenticateUserStateStatus.init,
          AuthenticateUserEntity detail,
          String errorMessage}) =>
      AuthenticateUserState(
          status: status ?? this.status,
          detail: detail ?? this.detail,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object> get props => [status ?? '', detail ?? '', errorMessage ?? ''];
}

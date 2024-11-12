import 'dart:async';
//import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/core/utils/const/const.dart';
import 'package:random_phishing/features/authenticate_user/domain/entities/authenticate_user_entity.dart';
import 'package:random_phishing/features/authenticate_user/domain/usecases/fetch_authenticate_user_usecase.dart';

part 'authenticate_user_event.dart';
part 'authenticate_user_state.dart';

class AuthenticateUserBloc
    extends Bloc<AuthenticateUserEvent, AuthenticateUserState> {
  late final FetchAuthenticateUserUseCase fetchAuthenticateUserUseCase;

  AuthenticateUserBloc(
      {required FetchAuthenticateUserUseCase fetchAuthenticateUserUseCase})
      : super(AuthenticateUserState(
            status: AuthenticateUserStateStatus.init,
            role: AuthenticateUserRole.admin,
            errorMessage: "asasaas")) {
    this.fetchAuthenticateUserUseCase = fetchAuthenticateUserUseCase;
    on<EventFetchAuthenticateUser>((event, emit) async {
      // Stream<AuthenticateUserState> res = _handleFetchPD(event);
      // print(res.last);
      await for (final newState in _handleFetchPD(event)) {
        // Emit the new state after handling the event
        emit(newState);

        // Log the new state after it has been emitted
        print('Role State: ${newState.toString()}');
      }
    });
  }

  Stream<AuthenticateUserState> _handleFetchPD(
      EventFetchAuthenticateUser event) async* {
    // yield state.copyWith(status: AuthenticateUserStateStatus.showLoading);
    final result = await fetchAuthenticateUserUseCase(
        FetchAuthenticateUserParam(
            username: event.username,
            password: event.password,
            isLoginAsGuest: event.loginasGuest));
    // yield state.copyWith(status: AuthenticateUserStateStatus.hideLoading);
    yield result.fold(
        (failure) => state.copyWith(
            status: AuthenticateUserStateStatus.loadedFailed,
            errorMessage: 'Có lỗi xảy ra. Vui lòng thử lại.'),
        (data) => state.copyWith(
            status: AuthenticateUserStateStatus.loadedSuccess,
            role: AuthenticateUserState.mapAuthenticateCodeToRole[data.role] ??
                AuthenticateUserRole.guest));
  }
}

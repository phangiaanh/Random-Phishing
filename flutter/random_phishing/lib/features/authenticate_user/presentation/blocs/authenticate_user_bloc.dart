import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/features/authenticate_user/domain/entities/authenticate_user_entity.dart';
import 'package:random_phishing/features/authenticate_user/domain/usecases/fetch_authenticate_user_usecase.dart';

part 'authenticate_user_event.dart';
part 'authenticate_user_state.dart';

class AuthenticateUserBloc
    extends Bloc<AuthenticateUserEvent, AuthenticateUserState> {
  final FetchAuthenticateUserUseCase fetchAuthenticateUserUseCase;

  AuthenticateUserBloc(
      {required FetchAuthenticateUserUseCase fetchAuthenticateUserUseCase})
      : this.fetchAuthenticateUserUseCase = fetchAuthenticateUserUseCase,
        super(AuthenticateUserState(status: AuthenticateUserStateStatus.init));

  @override
  Stream<AuthenticateUserState> mapEventToState(
      AuthenticateUserEvent event) async* {
    if (event is EventFetchAuthenticateUser) {
      yield* _handleFetchPD(event);
    }
  }

  Stream<AuthenticateUserState> _handleFetchPD(
      EventFetchAuthenticateUser event) async* {
    yield state.copyWith(status: AuthenticateUserStateStatus.showLoading);
    final result = await fetchAuthenticateUserUseCase(
        FetchAuthenticateUserParam(id: event.id));
    yield state.copyWith(status: AuthenticateUserStateStatus.hideLoading);
    yield result.fold(
        (failure) => state.copyWith(
            status: AuthenticateUserStateStatus.loadedFailed,
            errorMessage: 'Có lỗi xảy ra. Vui lòng thử lại.'),
        (data) => state.copyWith(
            status: AuthenticateUserStateStatus.loadedSuccess, detail: data));
  }
}

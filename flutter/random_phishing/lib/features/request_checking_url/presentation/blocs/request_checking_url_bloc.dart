import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/features/request_checking_url/domain/entities/request_checking_url_entity.dart';
import 'package:random_phishing/features/request_checking_url/domain/usecases/fetch_request_checking_url_usecase.dart';

part 'request_checking_url_event.dart';
part 'request_checking_url_state.dart';

class RequestCheckingUrlBloc extends Bloc<RequestCheckingUrlEvent, RequestCheckingUrlState> {
  final FetchRequestCheckingUrlUseCase fetchRequestCheckingUrlUseCase;

  RequestCheckingUrlBloc({
    @required FetchRequestCheckingUrlUseCase fetchRequestCheckingUrlUseCase
  })  : this.fetchRequestCheckingUrlUseCase = fetchRequestCheckingUrlUseCase,
        super(RequestCheckingUrlState(status: RequestCheckingUrlStateStatus.init));

  @override
  Stream<RequestCheckingUrlState> mapEventToState(RequestCheckingUrlEvent event) async* {
    if (event is EventFetchRequestCheckingUrl) {
      yield* _handleFetchPD(event);
    }
  }

  Stream<RequestCheckingUrlState> _handleFetchPD(EventFetchRequestCheckingUrl event) async* {
    yield state.copyWith(status: RequestCheckingUrlStateStatus.showLoading);
    final result = await fetchRequestCheckingUrlUseCase(FetchRequestCheckingUrlParam(id: event.id));
    yield state.copyWith(status: RequestCheckingUrlStateStatus.hideLoading);
    yield result.fold(
      (failure) => state.copyWith(status: RequestCheckingUrlStateStatus.loadedFailed, errorMessage: 'Có lỗi xảy ra. Vui lòng thử lại.'),
      (data) => state.copyWith(status: RequestCheckingUrlStateStatus.loadedSuccess, detail: data)
    );
  }
}

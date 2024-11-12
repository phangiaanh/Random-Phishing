import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/features/detect_phishing_url/domain/entities/detect_phishing_url_entity.dart';
import 'package:random_phishing/features/detect_phishing_url/domain/usecases/fetch_detect_phishing_url_usecase.dart';

part 'detect_phishing_url_event.dart';
part 'detect_phishing_url_state.dart';

class DetectPhishingUrlBloc
    extends Bloc<DetectPhishingUrlEvent, DetectPhishingUrlState> {
  final FetchDetectPhishingUrlUseCase fetchDetectPhishingUrlUseCase;

  DetectPhishingUrlBloc(
      {required FetchDetectPhishingUrlUseCase fetchDetectPhishingUrlUseCase})
      : this.fetchDetectPhishingUrlUseCase = fetchDetectPhishingUrlUseCase,
        super(DetectPhishingUrlState(
            status: DetectPhishingUrlStateStatus.init,
            detectTurn: 0,
            errorMessage: "")) {
    on<EventFetchDetectPhishingUrl>((event, emit) async {
      // Stream<AuthenticateUserState> res = _handleFetchPD(event);
      // print(res.last);
      await for (final newState in _handleFetchPD(event)) {
        // Emit the new state after handling the event
        emit(newState);

        // Log the new state after it has been emitted
        print('New State after emit: ${newState.toString()}');
      }
    });
  }

  Stream<DetectPhishingUrlState> _handleFetchPD(
      EventFetchDetectPhishingUrl event) async* {
    yield state.copyWith(status: DetectPhishingUrlStateStatus.showLoading);
    final result = await fetchDetectPhishingUrlUseCase(
        FetchDetectPhishingUrlParam(url: event.url, role: event.role));
    yield state.copyWith(status: DetectPhishingUrlStateStatus.hideLoading);
    yield result.fold(
        (failure) => state.copyWith(
            status: DetectPhishingUrlStateStatus.loadedFailed,
            errorMessage: 'Có lỗi xảy ra. Vui lòng thử lại.'),
        (data) => state.copyWith(
            status: DetectPhishingUrlStateStatus.loadedSuccess,
            detectTurn: data.detectTurn));
  }
}

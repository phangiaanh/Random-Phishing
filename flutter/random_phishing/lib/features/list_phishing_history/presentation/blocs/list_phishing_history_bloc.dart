import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/features/list_phishing_history/domain/entities/list_phishing_history_entity.dart';
import 'package:random_phishing/features/list_phishing_history/domain/usecases/fetch_list_phishing_history_usecase.dart';

part 'list_phishing_history_event.dart';
part 'list_phishing_history_state.dart';

class ListPhishingHistoryBloc extends Bloc<ListPhishingHistoryEvent, ListPhishingHistoryState> {
  final FetchListPhishingHistoryUseCase fetchListPhishingHistoryUseCase;

  ListPhishingHistoryBloc({
    @required FetchListPhishingHistoryUseCase fetchListPhishingHistoryUseCase
  })  : this.fetchListPhishingHistoryUseCase = fetchListPhishingHistoryUseCase,
        super(ListPhishingHistoryState(status: ListPhishingHistoryStateStatus.init));

  @override
  Stream<ListPhishingHistoryState> mapEventToState(ListPhishingHistoryEvent event) async* {
    if (event is EventFetchListPhishingHistory) {
      yield* _handleFetchPD(event);
    }
  }

  Stream<ListPhishingHistoryState> _handleFetchPD(EventFetchListPhishingHistory event) async* {
    yield state.copyWith(status: ListPhishingHistoryStateStatus.showLoading);
    final result = await fetchListPhishingHistoryUseCase(FetchListPhishingHistoryParam(id: event.id));
    yield state.copyWith(status: ListPhishingHistoryStateStatus.hideLoading);
    yield result.fold(
      (failure) => state.copyWith(status: ListPhishingHistoryStateStatus.loadedFailed, errorMessage: 'Có lỗi xảy ra. Vui lòng thử lại.'),
      (data) => state.copyWith(status: ListPhishingHistoryStateStatus.loadedSuccess, detail: data)
    );
  }
}

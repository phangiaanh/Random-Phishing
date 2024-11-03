import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/features/phishing_url_history/domain/entities/phishing_url_history_entity.dart';
import 'package:random_phishing/features/phishing_url_history/domain/usecases/fetch_phishing_url_history_usecase.dart';

part 'phishing_url_history_event.dart';
part 'phishing_url_history_state.dart';

class PhishingUrlHistoryBloc extends Bloc<PhishingUrlHistoryEvent, PhishingUrlHistoryState> {
  final FetchPhishingUrlHistoryUseCase fetchPhishingUrlHistoryUseCase;

  PhishingUrlHistoryBloc({
    @required FetchPhishingUrlHistoryUseCase fetchPhishingUrlHistoryUseCase
  })  : this.fetchPhishingUrlHistoryUseCase = fetchPhishingUrlHistoryUseCase,
        super(PhishingUrlHistoryState(status: PhishingUrlHistoryStateStatus.init));

  @override
  Stream<PhishingUrlHistoryState> mapEventToState(PhishingUrlHistoryEvent event) async* {
    if (event is EventFetchPhishingUrlHistory) {
      yield* _handleFetchPD(event);
    }
  }

  Stream<PhishingUrlHistoryState> _handleFetchPD(EventFetchPhishingUrlHistory event) async* {
    yield state.copyWith(status: PhishingUrlHistoryStateStatus.showLoading);
    final result = await fetchPhishingUrlHistoryUseCase(FetchPhishingUrlHistoryParam(id: event.id));
    yield state.copyWith(status: PhishingUrlHistoryStateStatus.hideLoading);
    yield result.fold(
      (failure) => state.copyWith(status: PhishingUrlHistoryStateStatus.loadedFailed, errorMessage: 'Có lỗi xảy ra. Vui lòng thử lại.'),
      (data) => state.copyWith(status: PhishingUrlHistoryStateStatus.loadedSuccess, detail: data)
    );
  }
}

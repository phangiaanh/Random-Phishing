
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:meta/meta.dart';
  
  part 'authenticate_user_event.dart';
  part 'authenticate_user_state.dart';
  
  class AuthenticateUserBloc extends Bloc<AuthenticateUserEvent, AuthenticateUserState> {
    AuthenticateUserBloc() : super(AuthenticateUserInitial()) {
      on<AuthenticateUserEvent>((event, emit) {
        // TODO: implement event handler
      });
    }
  }

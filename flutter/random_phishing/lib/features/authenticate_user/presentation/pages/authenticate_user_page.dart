import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/features/authenticate_user/di/authenticate_user_injector.dart';
import 'package:random_phishing/features/authenticate_user/presentation/blocs/authenticate_user_bloc.dart';

class AuthenticateUserPage extends StatefulWidget {
  const AuthenticateUserPage() : super();
  // final Map<String, dynamic> arguments;

  @override
  _AuthenticateUserPageState createState() => _AuthenticateUserPageState();
}

class _AuthenticateUserPageState extends State<AuthenticateUserPage> {
  bool _isLoading = false;
  late AuthenticateUserBloc _bloc;

  @override
  void initState() {
    _bloc = AuthenticateUserBloc(
        fetchAuthenticateUserUseCase: fetchAuthenticateUserUseCase);
    _fetchAuthenticateUserData();
    super.initState();
  }

  @override
  void dispose() {
    // _bloc = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('App bar')),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        BlocBuilder<AuthenticateUserBloc, AuthenticateUserState>(
          buildWhen: (previous, current) {
            return current.status ==
                    AuthenticateUserStateStatus.loadedSuccess ||
                current.status == AuthenticateUserStateStatus.loadedFailed;
          },
          builder: (_, state) {
            if (state.status == AuthenticateUserStateStatus.loadedSuccess) {
              return SafeArea(
                child: Stack(children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Center(child: Text('Welcome!')))
                ]),
              );
            } else if (state.status ==
                AuthenticateUserStateStatus.loadedFailed) {
              return Container(color: Colors.red);
            } else {
              return const SizedBox();
            }
          },
        ),
        BlocListener<AuthenticateUserBloc, AuthenticateUserState>(
          listenWhen: (previous, current) {
            return current.status == AuthenticateUserStateStatus.showLoading ||
                current.status == AuthenticateUserStateStatus.hideLoading;
          },
          listener: (_, state) {
            switch (state.status) {
              case AuthenticateUserStateStatus.showLoading:
                _handleLoadingData(true);
                break;
              case AuthenticateUserStateStatus.hideLoading:
                _handleLoadingData(false);
                break;
              default:
            }
          },
          child: _widgetLoading(_isLoading),
        ),
      ],
    );
  }

  Widget _widgetLoading(bool isLoading) {
    if (isLoading) {
      return Positioned.fill(
        child: Container(
          color: Colors.transparent,
          child: Center(child: Text('Loading...')),
        ),
      );
    }
    return const SizedBox();
  }

  void _handleLoadingData(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  void _fetchAuthenticateUserData() {
    _bloc?.add(EventFetchAuthenticateUser(id: 'xxx'));
  }
}

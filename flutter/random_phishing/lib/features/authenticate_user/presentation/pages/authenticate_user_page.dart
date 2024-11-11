import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:random_phishing/core/utils/const/const.dart';
import 'package:random_phishing/core/utils/router/router.dart';
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
  bool isLogin = false;
  bool _isUserEmpty = false;
  bool _isPassEmpty = false;
  late AuthenticateUserBloc _bloc;

  @override
  void initState() {
    _bloc = AuthenticateUserBloc(
        fetchAuthenticateUserUseCase: fetchAuthenticateUserUseCase);
    // _fetchAuthenticateUserData();
    super.initState();
  }

  @override
  void dispose() {
    // _bloc = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget widgetLeading;
    if (isLogin) {
      widgetLeading = ElevatedButton(
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent),
          onPressed: () {
            setState(() {
              isLogin = false;
            });
          },
          child: Icon(Icons.arrow_back));
    } else {
      widgetLeading = SizedBox.shrink();
    }
    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          leading: widgetLeading,
          backgroundColor: Colors.redAccent,
          title: Center(
            child: Text(
              'PhishTank',
              style: theme.textTheme.displayMedium!.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: _buildLogin(context),
      ),
    );
  }

  Widget _buildLogin(BuildContext context) {
    if (isLogin) {
      TextEditingController _inputUserController = TextEditingController();
      TextEditingController _inputPassController = TextEditingController();
      return Dialog(
        backgroundColor: Colors.transparent, // Transparent background
        child: Stack(
          children: [
            // Apply a blur effect to the background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(color: Colors.black.withOpacity(0)),
              ),
            ),
            // Your login form (in the center)
            Center(
              child: Container(
                width: 500,
                // padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _inputUserController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.verified_user),
                          labelText: "Username",
                          errorText:
                              _isUserEmpty ? "Username can't be empty" : null),
                    ),
                    TextField(
                      controller: _inputPassController,
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(Icons.password),
                          labelText: "Password",
                          errorText:
                              _isPassEmpty ? "Password can't be empty" : null),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle login action
                        setState(() {
                          _isUserEmpty = _inputUserController.text.isEmpty;
                          _isPassEmpty = _inputPassController.text.isEmpty;
                        });
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return chooseLoginMethod();
    }
  }

  Center chooseLoginMethod() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  print('Continue as Guest');
                  setState(() {
                    isLogin = true;
                  });
                },
                // icon: Icon(icon),
                label: Text('Login'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  print('Continue as Guest');
                },
                child: Text('Continue as Guest'),
              ),
            ],
          )
        ],
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
              return const SafeArea(
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

  // void _fetchAuthenticateUserData() {
  //   _bloc.add(EventFetchAuthenticateUser(id: 'xxx'));
  // }
}

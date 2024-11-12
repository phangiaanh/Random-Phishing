//import 'dart:ffi';
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
  bool _isLogin = false;
  bool _isUserEmpty = false;
  bool _isPassEmpty = false;
  bool _isValidUserPass = true;
  late AuthenticateUserBloc _bloc;

  @override
  void initState() {
    // _bloc = AuthenticateUserBloc(
    //     fetchAuthenticateUserUseCase: fetchAuthenticateUserUseCase);
    _bloc = context.read<AuthenticateUserBloc>();
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
    if (_isLogin) {
      widgetLeading = ElevatedButton(
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent),
          onPressed: () {
            setState(() {
              _isLogin = false;
              _isValidUserPass = true;
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
    if (_isLogin) {
      TextEditingController _inputUserController = TextEditingController();
      TextEditingController _inputPassController = TextEditingController();

      Widget checkUserPass;
      if (_isValidUserPass) {
        checkUserPass = SizedBox.shrink();
      } else {
        checkUserPass = Center(
          child: Text(
            "Invalid User or Password",
            style: TextStyle(color: Colors.blue),
          ),
        );
      }

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
                    BlocListener<AuthenticateUserBloc, AuthenticateUserState>(
                      listenWhen: (previous, current) {
                        return current.status ==
                            AuthenticateUserStateStatus.loadedSuccess;
                      },
                      listener: (_, state) {
                        if (state.status ==
                            AuthenticateUserStateStatus.loadedSuccess) {
                          context.push(ConstParameters.HomePage);
                        }
                      },
                      child: BlocBuilder<AuthenticateUserBloc,
                          AuthenticateUserState>(
                        buildWhen: (previous, current) {
                          return current.status ==
                                  AuthenticateUserStateStatus.loadedFailed ||
                              previous.status ==
                                  AuthenticateUserStateStatus.init;
                        },
                        builder: (_, state) {
                          if (state.status ==
                              AuthenticateUserStateStatus.loadedFailed) {
                            _isValidUserPass = false;
                          }
                          if (_isValidUserPass) {
                            return SizedBox.shrink();
                          } else {
                            return Center(
                              child: Text(
                                "Invalid User or Password",
                                style: TextStyle(color: Colors.blue),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    // BlocListener<AuthenticateUserBloc, AuthenticateUserState>(
                    // listenWhen: (previous, current) {
                    //   return current.status ==
                    //       AuthenticateUserStateStatus.loadedSuccess;
                    // },
                    // listener: (_, state) {
                    //   if (state.status ==
                    //       AuthenticateUserStateStatus.loadedSuccess) {
                    //     // context.go(ConstParameters.HomePage);
                    //   }
                    // },
                    // ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle login action
                        setState(() {
                          _isUserEmpty = _inputUserController.text.isEmpty;
                          _isPassEmpty = _inputPassController.text.isEmpty;
                        });

                        if (!_isUserEmpty & !_isPassEmpty) {
                          _fetchAuthenticateUserData(_inputUserController.text,
                              _inputPassController.text, false);
                        }
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
                  setState(() {
                    _isLogin = true;
                    _isValidUserPass = true;
                    _isUserEmpty = false;
                    _isPassEmpty = false;
                  });
                },
                // icon: Icon(icon),
                label: Text('Login'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _fetchAuthenticateUserData("", "", true);
                  context.push(ConstParameters.HomePage);
                },
                child: Text('Continue as Guest'),
              ),
            ],
          )
        ],
      ),
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

  void _fetchAuthenticateUserData(
      String username, String password, bool isGuest) {
    _bloc.add(EventFetchAuthenticateUser(
        username: username, password: password, loginasGuest: isGuest));
  }
}

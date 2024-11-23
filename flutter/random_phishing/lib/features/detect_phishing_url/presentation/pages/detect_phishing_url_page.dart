import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:random_phishing/core/utils/const/const.dart';
import 'package:random_phishing/features/authenticate_user/presentation/blocs/authenticate_user_bloc.dart';
import 'package:random_phishing/features/detect_phishing_url/di/detect_phishing_url_injector.dart';
import 'package:random_phishing/features/detect_phishing_url/domain/usecases/fetch_detect_phishing_url_usecase.dart';
import 'package:random_phishing/features/detect_phishing_url/presentation/blocs/detect_phishing_url_bloc.dart';

class DetectPhishingUrlPage extends StatefulWidget {
  const DetectPhishingUrlPage() : super();

  @override
  _DetectPhishingUrlPageState createState() => _DetectPhishingUrlPageState();
}

class _DetectPhishingUrlPageState extends State<DetectPhishingUrlPage> {
  bool _isLoading = false;
  var selectedIndex = 0;
  late AuthenticateUserBloc _roleBloc;

  @override
  void initState() {
    _roleBloc = context.read<AuthenticateUserBloc>();
    // _fetchDetectPhishingUrlData();
    super.initState();
  }

  @override
  void dispose() {
    // _bloc = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(title: Text('App bar')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Widget page;
    // switch (selectedIndex) {
    //   case 0:
    //     page = DetectPhishingUrlExtendPage();
    //     break;
    //   // case 1:
    //   //   page = FavoritePage();
    //   //   break;
    //   default:
    //     page = DetectPhishingUrlExtendPage();
    //     break;
    //   // throw UnimplementedError('no widget for $selectedIndex');
    // }

    return LayoutBuilder(builder: (context, constraints) {
      List<Map<String, Widget>> listPermissions =
          PermissionNavigationByRole.role[AuthenticateUserState
              .mapAuthenticateRoleToCode[_roleBloc.state.role]];
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  for (var i in listPermissions)
                    NavigationRailDestination(
                        icon: i["icon"] ?? Icon(Icons.holiday_village),
                        label: i["label"] ?? Text("Holiday"))
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  if (value == (listPermissions.length - 1)) {
                    context.pop();
                  } else {
                    setState(() {
                      selectedIndex = value;
                    });
                  }
                },
              ),
            ),
            Expanded(
                child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: listPermissions[selectedIndex]["page"],
            )),
          ],
        ),
      );
    });
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

  // void _fetchDetectPhishingUrlData(String url) {
  //   _bloc.add(EventFetchDetectPhishingUrl(
  //       url: url,
  //       role: AuthenticateUserState
  //           .mapAuthenticateRoleToCode[_roleBloc.state.role]));
  // }
}

class DetectPhishingUrlExtendPage extends StatefulWidget {
  const DetectPhishingUrlExtendPage() : super();

  @override
  _DetectPhishingUrlExtendPageState createState() =>
      _DetectPhishingUrlExtendPageState();
}

class _DetectPhishingUrlExtendPageState
    extends State<DetectPhishingUrlExtendPage> {
  bool _isLoading = false;
  bool _isEnable = true;
  var selectedIndex = 0;
  bool _isURLEmpty = false;
  late DetectPhishingUrlBloc _bloc;
  late AuthenticateUserBloc _roleBloc;
  TextEditingController _inputURLController = TextEditingController();

  @override
  void initState() {
    _roleBloc = context.read<AuthenticateUserBloc>();
    _bloc = DetectPhishingUrlBloc(
        fetchDetectPhishingUrlUseCase: fetchDetectPhishingUrlUseCase);
    // _fetchDetectPhishingUrlData();
    super.initState();
  }

  @override
  void dispose() {
    // _bloc = null;
    super.dispose();
  }

  void _fetchDetectPhishingUrlData(String url) {
    _bloc.add(EventFetchDetectPhishingUrl(
        url: url,
        role: AuthenticateUserState
            .mapAuthenticateRoleToCode[_roleBloc.state.role],
        user: _roleBloc.state.user));
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold();
    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
        backgroundColor: Colors.deepOrange[50],
        body: BlocListener<DetectPhishingUrlBloc, DetectPhishingUrlState>(
          listenWhen: (previous, current) {
            return current.detectTurn >= 5;
          },
          listener: (context, state) => {
            if (_roleBloc.state.role == AuthenticateUserRole.guest)
              {_isEnable = false}
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Enter URL",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30),
                    BlocBuilder<DetectPhishingUrlBloc, DetectPhishingUrlState>(
                      buildWhen: (previous, current) {
                        return (current.status ==
                                    DetectPhishingUrlStateStatus
                                        .loadedSuccess ||
                                current.status ==
                                    DetectPhishingUrlStateStatus
                                        .loadedFailed) &&
                            (current.detectTurn != -1 &&
                                current.detectTurn <= 5);
                      },
                      builder: (context, state) {
                        if (_roleBloc.state.role ==
                            AuthenticateUserRole.guest) {
                          return Text(
                              "You have ${5 - state.detectTurn} attempt${(state.detectTurn >= 4) ? "" : "s"}");
                        }

                        return SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: 30),
                    TextField(
                      enabled: _isEnable,
                      controller: _inputURLController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.link),
                          labelText: "URL",
                          errorText:
                              _isURLEmpty ? "Please input the link" : null),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // // Handle login action
                        setState(() {
                          _isURLEmpty = _inputURLController.text.isEmpty;
                        });

                        if (!_isURLEmpty) {
                          _fetchDetectPhishingUrlData(_inputURLController.text);
                        }
                      },
                      child: Text("Check"),
                    ),
                    SizedBox(height: 30),
                    BlocBuilder<DetectPhishingUrlBloc, DetectPhishingUrlState>(
                      buildWhen: (previous, current) {
                        return (current.status ==
                                    DetectPhishingUrlStateStatus
                                        .loadedSuccess ||
                                current.status ==
                                    DetectPhishingUrlStateStatus
                                        .loadedFailed) &&
                            (previous.status !=
                                DetectPhishingUrlStateStatus.init);
                      },
                      builder: (context, state) {
                        Widget textWidget = SizedBox.shrink();
                        Widget reasonWidget = SizedBox.shrink();
                        if (state.status ==
                            DetectPhishingUrlStateStatus.loadedSuccess) {
                          textWidget = Text(
                            "${_inputURLController.text} is a valid link",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          );
                        } else if (state.status ==
                            DetectPhishingUrlStateStatus.loadedFailed) {
                          textWidget = Text(
                            "${_inputURLController.text} is a phishing link",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          );
                        }

                        if (_roleBloc.state.role !=
                            AuthenticateUserRole.guest) {
                          reasonWidget = Text("Reason: ${state.errorMessage}");
                        }

                        return Column(
                          children: [textWidget, reasonWidget],
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/features/phishing_url_history/di/phishing_url_history_injector.dart';
import 'package:random_phishing/features/phishing_url_history/presentation/blocs/phishing_url_history_bloc.dart';

class PhishingUrlHistoryPage extends StatefulWidget {
  const PhishingUrlHistoryPage({Key key, this.arguments}) : super(key: key);
  final Map<String, dynamic> arguments;

  @override
  _PhishingUrlHistoryPageState createState() => _PhishingUrlHistoryPageState();
}

class _PhishingUrlHistoryPageState extends State<PhishingUrlHistoryPage> {
  bool _isLoading = false;
  PhishingUrlHistoryBloc _bloc;

  @override
  void initState() {
    _bloc = PhishingUrlHistoryBloc(fetchPhishingUrlHistoryUseCase: fetchPhishingUrlHistoryUseCase);
    _fetchPhishingUrlHistoryData();
    super.initState();
  }

  @override
  void dispose() {
    _bloc = null;
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
        BlocBuilder<PhishingUrlHistoryBloc, PhishingUrlHistoryState>(
          buildWhen: (previous, current) {
            return current.status == PhishingUrlHistoryStateStatus.loadedSuccess ||
                current.status == PhishingUrlHistoryStateStatus.loadedFailed;
          },
          builder: (_, state) {
            if (state.status == PhishingUrlHistoryStateStatus.loadedSuccess) {
              return SafeArea(
                child: Stack(
                  children: [Positioned(top: 0, left: 0, right: 0, bottom: 0, child: Center(child: Text('Welcome!')))
                  ]
                ),
              );
            } else if (state.status == PhishingUrlHistoryStateStatus.loadedFailed) {
              return Container(color: Colors.red);
            } else {
              return const SizedBox();
            }
          },
        ),
        BlocListener<PhishingUrlHistoryBloc, PhishingUrlHistoryState>(
          listenWhen: (previous, current) {
            return current.status == PhishingUrlHistoryStateStatus.showLoading || current.status == PhishingUrlHistoryStateStatus.hideLoading;
          },
          listener: (_, state) {
            switch (state.status) {
              case PhishingUrlHistoryStateStatus.showLoading:
                _handleLoadingData(true);
                break;
              case PhishingUrlHistoryStateStatus.hideLoading:
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

  void _fetchPhishingUrlHistoryData() {
    _bloc?.add(EventFetchPhishingUrlHistory(id: 'xxx'));
  }
}

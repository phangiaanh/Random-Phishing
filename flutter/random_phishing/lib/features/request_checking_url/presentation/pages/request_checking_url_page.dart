import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/features/request_checking_url/di/request_checking_url_injector.dart';
import 'package:random_phishing/features/request_checking_url/presentation/blocs/request_checking_url_bloc.dart';

class RequestCheckingUrlPage extends StatefulWidget {
  const RequestCheckingUrlPage({Key? key, this.arguments}) : super(key: key);
  final Map<String, dynamic>? arguments;

  @override
  _RequestCheckingUrlPageState createState() => _RequestCheckingUrlPageState();
}

class _RequestCheckingUrlPageState extends State<RequestCheckingUrlPage> {
  bool _isLoading = false;
  RequestCheckingUrlBloc? _bloc;

  @override
  void initState() {
    _bloc = RequestCheckingUrlBloc(fetchRequestCheckingUrlUseCase: fetchRequestCheckingUrlUseCase);
    _fetchRequestCheckingUrlData();
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
        BlocBuilder<RequestCheckingUrlBloc, RequestCheckingUrlState>(
          buildWhen: (previous, current) {
            return current.status == RequestCheckingUrlStateStatus.loadedSuccess ||
                current.status == RequestCheckingUrlStateStatus.loadedFailed;
          },
          builder: (_, state) {
            if (state.status == RequestCheckingUrlStateStatus.loadedSuccess) {
              return SafeArea(
                child: Stack(
                  children: [Positioned(top: 0, left: 0, right: 0, bottom: 0, child: Center(child: Text('Welcome!')))
                  ]
                ),
              );
            } else if (state.status == RequestCheckingUrlStateStatus.loadedFailed) {
              return Container(color: Colors.red);
            } else {
              return const SizedBox();
            }
          },
        ),
        BlocListener<RequestCheckingUrlBloc, RequestCheckingUrlState>(
          listenWhen: (previous, current) {
            return current.status == RequestCheckingUrlStateStatus.showLoading || current.status == RequestCheckingUrlStateStatus.hideLoading;
          },
          listener: (_, state) {
            switch (state.status) {
              case RequestCheckingUrlStateStatus.showLoading:
                _handleLoadingData(true);
                break;
              case RequestCheckingUrlStateStatus.hideLoading:
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

  void _fetchRequestCheckingUrlData() {
    _bloc?.add(EventFetchRequestCheckingUrl(id: 'xxx'));
  }
}

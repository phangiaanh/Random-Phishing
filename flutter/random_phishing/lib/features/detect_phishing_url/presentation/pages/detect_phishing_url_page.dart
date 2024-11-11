import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/features/detect_phishing_url/di/detect_phishing_url_injector.dart';
import 'package:random_phishing/features/detect_phishing_url/presentation/blocs/detect_phishing_url_bloc.dart';

class DetectPhishingUrlPage extends StatefulWidget {
  const DetectPhishingUrlPage() : super();

  @override
  _DetectPhishingUrlPageState createState() => _DetectPhishingUrlPageState();
}

class _DetectPhishingUrlPageState extends State<DetectPhishingUrlPage> {
  bool _isLoading = false;
  late DetectPhishingUrlBloc _bloc;

  @override
  void initState() {
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
        BlocBuilder<DetectPhishingUrlBloc, DetectPhishingUrlState>(
          buildWhen: (previous, current) {
            return current.status ==
                    DetectPhishingUrlStateStatus.loadedSuccess ||
                current.status == DetectPhishingUrlStateStatus.loadedFailed;
          },
          builder: (_, state) {
            if (state.status == DetectPhishingUrlStateStatus.loadedSuccess) {
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
                DetectPhishingUrlStateStatus.loadedFailed) {
              return Container(color: Colors.red);
            } else {
              return const SizedBox();
            }
          },
        ),
        BlocListener<DetectPhishingUrlBloc, DetectPhishingUrlState>(
          listenWhen: (previous, current) {
            return current.status == DetectPhishingUrlStateStatus.showLoading ||
                current.status == DetectPhishingUrlStateStatus.hideLoading;
          },
          listener: (_, state) {
            switch (state.status) {
              case DetectPhishingUrlStateStatus.showLoading:
                _handleLoadingData(true);
                break;
              case DetectPhishingUrlStateStatus.hideLoading:
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

  void _fetchDetectPhishingUrlData(String url) {
    _bloc.add(EventFetchDetectPhishingUrl(url: url));
  }
}

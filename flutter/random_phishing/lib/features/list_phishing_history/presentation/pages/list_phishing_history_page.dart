import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/features/list_phishing_history/di/list_phishing_history_injector.dart';
import 'package:random_phishing/features/list_phishing_history/presentation/blocs/list_phishing_history_bloc.dart';

class ListPhishingHistoryPage extends StatefulWidget {
  const ListPhishingHistoryPage({Key key, this.arguments}) : super(key: key);
  final Map<String, dynamic> arguments;

  @override
  _ListPhishingHistoryPageState createState() => _ListPhishingHistoryPageState();
}

class _ListPhishingHistoryPageState extends State<ListPhishingHistoryPage> {
  bool _isLoading = false;
  ListPhishingHistoryBloc _bloc;

  @override
  void initState() {
    _bloc = ListPhishingHistoryBloc(fetchListPhishingHistoryUseCase: fetchListPhishingHistoryUseCase);
    _fetchListPhishingHistoryData();
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
        BlocBuilder<ListPhishingHistoryBloc, ListPhishingHistoryState>(
          buildWhen: (previous, current) {
            return current.status == ListPhishingHistoryStateStatus.loadedSuccess ||
                current.status == ListPhishingHistoryStateStatus.loadedFailed;
          },
          builder: (_, state) {
            if (state.status == ListPhishingHistoryStateStatus.loadedSuccess) {
              return SafeArea(
                child: Stack(
                  children: [Positioned(top: 0, left: 0, right: 0, bottom: 0, child: Center(child: Text('Welcome!')))
                  ]
                ),
              );
            } else if (state.status == ListPhishingHistoryStateStatus.loadedFailed) {
              return Container(color: Colors.red);
            } else {
              return const SizedBox();
            }
          },
        ),
        BlocListener<ListPhishingHistoryBloc, ListPhishingHistoryState>(
          listenWhen: (previous, current) {
            return current.status == ListPhishingHistoryStateStatus.showLoading || current.status == ListPhishingHistoryStateStatus.hideLoading;
          },
          listener: (_, state) {
            switch (state.status) {
              case ListPhishingHistoryStateStatus.showLoading:
                _handleLoadingData(true);
                break;
              case ListPhishingHistoryStateStatus.hideLoading:
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

  void _fetchListPhishingHistoryData() {
    _bloc?.add(EventFetchListPhishingHistory(id: 'xxx'));
  }
}

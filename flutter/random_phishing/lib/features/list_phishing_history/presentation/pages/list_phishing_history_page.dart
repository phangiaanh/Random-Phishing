import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:random_phishing/core/utils/const/const.dart';
import 'package:random_phishing/features/authenticate_user/presentation/blocs/authenticate_user_bloc.dart';
import 'package:random_phishing/features/list_phishing_history/di/list_phishing_history_injector.dart';
import 'package:random_phishing/features/list_phishing_history/domain/entities/list_phishing_history_entity.dart';
import 'package:random_phishing/features/list_phishing_history/presentation/blocs/list_phishing_history_bloc.dart';

class ListPhishingHistoryPage extends StatefulWidget {
  const ListPhishingHistoryPage() : super();

  @override
  _ListPhishingHistoryPageState createState() =>
      _ListPhishingHistoryPageState();
}

class _ListPhishingHistoryPageState extends State<ListPhishingHistoryPage> {
  late ListPhishingHistoryBloc _bloc;
  late AuthenticateUserBloc _roleBloc;

  @override
  void initState() {
    _bloc = ListPhishingHistoryBloc(
        fetchListPhishingHistoryUseCase: fetchListPhishingHistoryUseCase);
    _roleBloc = context.read<AuthenticateUserBloc>();
    // _fetchListPhishingHistoryData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    _fetchListPhishingHistoryData();
    return BlocBuilder<ListPhishingHistoryBloc, ListPhishingHistoryState>(
      buildWhen: (previous, current) {
        return current.status == ListPhishingHistoryStateStatus.loadedSuccess;
      },
      builder: (context, state) {
        return ListView.separated(
            padding: const EdgeInsets.all(8),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: state.detail.list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.white),
                  // color: state.detail.list[index].isPhishing
                  //     ? Colors.red
                  //     : Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(children: [
                  SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FittedBox(
                      child: Text(
                        "${DateFormat('yyyy-MM-dd – kk:mm').format(state.detail.list[index].time)}",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    height: 40,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.white),
                      color: state.detail.list[index].isPhishing
                          ? Colors.red
                          : Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FittedBox(
                      child: Text("${state.detail.list[index].url}",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 5),
                  (_roleBloc.state.role == AuthenticateUserRole.admin)
                      ? Container(
                          padding: const EdgeInsets.all(5.0),
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: DataSourceUser.user.containsKey(
                                        state.detail.list[index].username)
                                    ? DataSourceUser.user[state
                                        .detail.list[index].username]["color"]
                                    : Colors.black),
                            color: DataSourceUser.user.containsKey(
                                    state.detail.list[index].username)
                                ? DataSourceUser
                                        .user[state.detail.list[index].username]
                                    ["color"]
                                : Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: FittedBox(
                            child: Text(
                              "${DataSourceUser.user.containsKey(state.detail.list[index].username) ? state.detail.list[index].username : "anonymous"}",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ]),
              );
            });
      },
    );
  }

  void _fetchListPhishingHistoryData() {
    _bloc.add(EventFetchListPhishingHistory(username: _roleBloc.state.user));
  }
}

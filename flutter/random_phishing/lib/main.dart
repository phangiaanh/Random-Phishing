import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_phishing/core/utils/router/router.dart';
import 'package:random_phishing/features/authenticate_user/di/authenticate_user_injector.dart';
import 'package:random_phishing/features/authenticate_user/presentation/blocs/authenticate_user_bloc.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticateUserBloc _bloc = AuthenticateUserBloc(
      fetchAuthenticateUserUseCase: fetchAuthenticateUserUseCase);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: MaterialApp.router(
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
        title: 'PhishTank',
        debugShowCheckedModeBanner: false,
        routerConfig: MyAppRouterConfig().router,
      ),
    );
  }
}

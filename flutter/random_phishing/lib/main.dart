import 'package:flutter/material.dart';
import 'package:random_phishing/core/utils/router/router.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
      title: 'PhishTank',
      debugShowCheckedModeBanner: false,
      routerConfig: MyAppRouterConfig().router,
    );
  }
}

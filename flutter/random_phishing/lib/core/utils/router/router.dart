import 'package:go_router/go_router.dart';
import 'package:random_phishing/core/utils/const/const.dart';
import 'package:random_phishing/features/authenticate_user/presentation/pages/authenticate_user_page.dart';
import 'package:random_phishing/features/authenticate_user/presentation/pages/guest_page.dart';

class MyAppRouterConfig {
  final router = GoRouter(routes: [
    GoRoute(
      path: ConstParameters.LoginPage,
      builder: (context, state) => AuthenticateUserPage(),
    ),
    GoRoute(
      path: ConstParameters.HomePage,
      builder: (context, state) => HomePage(),
    ),
    // GoRoute(path: ConstParameters.HistoryPage),
    // GoRoute(path: ConstParameters.HistoryPage),
  ]);
}

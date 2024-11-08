import 'package:go_router/go_router.dart';
import 'package:random_phishing/core/utils/const/const.dart';
import 'package:random_phishing/features/authenticate_user/presentation/pages/authenticate_user_page.dart';

class MyAppRouterConfig {
  final router = GoRouter(routes: [
    GoRoute(
      path: ConstParameters.HomePage,
      builder: (context, state) => const AuthenticateUserPage(),
    ),
    GoRoute(path: ConstParameters.HistoryPage),
    GoRoute(path: ConstParameters.HistoryPage),
    GoRoute(path: ConstParameters.HistoryPage),
  ]);
}

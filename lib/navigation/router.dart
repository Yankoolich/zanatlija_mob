import 'package:auto_route/auto_route.dart';
import 'package:zanatlija_app/navigation/router.gr.dart';
import 'package:zanatlija_app/navigation/routes.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: Splash.page,
          path: kSplashRoute,
        ),
      ];
}

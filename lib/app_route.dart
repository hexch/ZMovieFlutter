import 'package:get/get.dart';
import 'package:zmovies/getx/app_binding.dart';
import 'package:zmovies/ui/controller/home_controller.dart';
import 'package:zmovies/ui/controller/movie_detail_controller.dart';
import 'package:zmovies/ui/controller/splash_controller.dart';
import 'package:zmovies/ui/screen/home_page.dart';
import 'package:zmovies/ui/screen/movie_detail_page.dart';
import 'package:zmovies/ui/screen/splash_page.dart';

/// Routes defination.
enum AppRoute {
  splash,
  home,
  detail,
}

/// Routes array.
final gAppRoutes = [
  GetPage(
    //splash screen
    name: AppRoute.splash.path,
    page: AppRoute.splash.pageBuilder,
    binding: AppBinding(() => SplashController(), false),
    participatesInRootNavigator: true,
    preventDuplicates: true,
    transition: Transition.fadeIn,
    transitionDuration: Duration(seconds: 1),
    children: [
      GetPage(
          //Home screen
          name: AppRoute.home.path,
          page: AppRoute.home.pageBuilder,
          bindings: [AppBinding(() => HomeController())],
          preventDuplicates: true,
          transition: Transition.zoom,
          children: [
            GetPage(
              //Movie detail screen
              name: AppRoute.detail.path,
              page: AppRoute.detail.pageBuilder,
              bindings: [AppBinding(() => MovieDetailController())],
              preventDuplicates: false,
              transition: Transition.downToUp,
              fullscreenDialog: true,
            )
          ]),
    ],
  ),
];

extension AppRouteExtension on AppRoute {
  /// Path of route.
  String get path => _pathMap[this]!;

  /// [GetPageBuilder] of route.
  GetPageBuilder get pageBuilder => _getPageBuilderMap[this]!;

  /// [Bindings]array of route.
  List<Bindings> get appBindings => _getAppBindingMap[this]!;

  static final Map<AppRoute, GetPageBuilder> _getPageBuilderMap = {
    AppRoute.splash: () => SplashPage(),
    AppRoute.home: () => HomePage(),
    AppRoute.detail: () => MovieDetailPage(),
  };
  static final Map<AppRoute, List<AppBinding>> _getAppBindingMap = {
    AppRoute.splash: [AppBinding(() => SplashController(), false)],
    AppRoute.home: [AppBinding(() => HomeController())],
    AppRoute.detail: [AppBinding(() => MovieDetailController())],
  };
  static final Map<AppRoute, String> _pathMap = {
    AppRoute.splash: '/',
    AppRoute.home: '/home',
    AppRoute.detail: '/detail'
  };
}
